# -*- coding: utf-8 -*-
require 'net/smtp'

if __FILE__ ==$0
  $: << '../..'
  require 'keystone'
end

module Keystone
  module Mail
    class Send
      attr_accessor :message, :smtp_addr, :smtp_port, :retry_cnt

      #
      # 普通なことをしたいならTMailを使いましょう
      #    class Send
      def initialize(message=nil,opt={})
        @smtp_addr, @smtp_port, @retry_cnt = "127.0.0.1", 25, 0
        @message = message
        @message = Keystone::Mail::MessageFactory.create(opt) if @message == nil
        Keystone::Base::Logger.instance.debug "@message=#{@message}"
        set_option(opt)
      end

      #
      # from could be String or Array
      # opt 
      #   :smtp_addr 
      #   :smtp_port 
      #   :retry
      #   :mail_from_text 
      #   :encoding
      #
      def self.send(from, to, subject, body, opt={})
        queue = self.new(nil,opt)
        queue.message.mail_to = to
        queue.message.mail_from = from
        queue.message.subject = subject
        queue.message.body = body
        queue.send
      end
      
      def send
        src = @message.to_src
        Keystone::Base::Logger.instance.debug src.encoding
        Keystone::Base::Logger.instance.debug src
        try_cnt = 0
        begin
          m = Net::SMTPSession.new(@smtp_addr, @smtp_port)
          m.start()
          mail_to = []
          @message.mail_to.each{|m_to|mail_to << m_to.encode("US-ASCII")}
          mail_from = @message.mail_from.encode("US-ASCII")
          
          m.sendmail(src ,mail_from ,mail_to)
          m.finish
        rescue => e
          Keystone::Base::Logger.instance.debug "try_cnt:#{try_cnt}"
          try_cnt += 1
          sleep 1
          retry if @retry_cnt >= try_cnt
          raise e
        end
      end
      
      def set_option(opt)
        @smtp_addr = opt[:smtp_addr] if opt.key?(:smtp_addr)
        @smtp_port = opt[:smtp_port] if opt.key?(:smtp_port)
        @retry_cnt = Integer(opt[:retry_cnt]) if opt.key?(:retry_cnt)
      end
    end
  end
end

if __FILE__ ==$0
  require 'rubygems'
  require 'pit'

  config = Pit.get("keystone_test")
  
  Keystone::Mail::Send.send(
    config["mailfrom01"],
    config["mailto01"],
    "件名かんさいーーーーでんきほーーーあんｋｙ−−−かいいい−−かいいい−−かいいいいいいいい終わり",
    "body日本語",
    {:mail_from_text=>"メール送信者名ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー終わり",:retry_cnt=>3,:encoding=>:sjis}
  )
end

