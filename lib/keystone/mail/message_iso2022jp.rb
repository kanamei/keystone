require 'kconv'

module Keystone
  module Mail
    #
    # encoding 未実装
    #
    #
    class MessageIso2022jp < Keystone::Mail::Message
      def encode_mime(st)
        Kconv.tojis(st)
      end
      
      def mime_header_string
        "=?ISO-2022-JP?B?"        
      end      

      def encode_body
        Kconv.tojis(@body)
      end

      # #
      # # 普通なことをしたいならTMailを使いましょう
      # #    class Send
      # def initialize(opt={})
      #   @smtp_addr, @smtp_port    = "127.0.0.1", 25
      #   @subject, @mail_from_text = "" ,nil
      #   @retry_cnt, @encoding     = 0, :iso2022jp
      #   set_option(opt)
      # end
      # 
      # #
      # # from could be String or Array
      # # opt 
      # #   :smtp_addr 
      # #   :smtp_port 
      # #   :retry
      # #   :mail_from_text 
      # #   :encoding
      # #
      # def self.send(from, to, subject, body, opt={})
      #   queue = self.new(opt)
      #   queue.mail_to = to
      #   queue.mail_from = from
      #   queue.subject = subject
      #   queue.body = body
      #   queue.send
      # end
      # 
      # def send
      #   raise "mail_to must not be blank!" if @mail_to.blank?
      #   raise "mail_from must not be blank!" if @mail_from.blank?
      #   header = ""
      #   header += create_mailfrom_header(@mail_from,@mail_from_text)
      #   header += create_mailto_header(@mail_to)
      #   header += create_subject_header(@subject)
      # 
      #   case @encoding
      #   when :iso2022jp
      #     body_encoded = Kconv.tojis(@body)
      #   else
      #     raise "encoding #{encoding.to_s} can not use"
      #   end
      #   
      #   src = header + "\n" + body_encoded
      #   debug src
      #   try_cnt = 0
      #   begin
      #     m = Net::SMTPSession.new(smtp_addr, smtp_port)
      #     m.start()
      #     m.sendmail(src ,@mail_from ,@mail_to)
      #     m.finish
      #   rescue => e
      #     debug "try_cnt:#{try_cnt}"
      #     try_cnt += 1
      #     sleep 1
      #     retry if @retry_cnt >= try_cnt
      #     raise e
      #   end
      # end
      # 
      # def set_option(opt)
      #   @smtp_addr = opt[:smtp_addr] if opt.key?(:smtp_addr)
      #   @smtp_port = opt[:smtp_port] if opt.key?(:smtp_port)
      #   @retry_cnt = Integer(opt[:retry_cnt]) if opt.key?(:retry_cnt)
      #   @mail_from_text = opt[:mail_from_text] if opt.key?(:mail_from_text)
      #   @encoding = opt[:encoding] if opt.key?(:encoding)
      # end
      # 
      # private
      # 
      # def to_mail_header(header_name, plain_text)
      #   ret = ""
      #   str = plain_text.clone
      #   str.gsub!(/(\r|\n)/,"")
      #   str.split(//).split_by(10).each do |ar|
      #     st = ar.join('')
      #     st = Kconv.tojis(st)
      #     st = st.split(//,1).pack('m'); st = st.chomp
      #     ret += " =?ISO-2022-JP?B?#{st}?=\n"   
      #   end
      #   return "#{header_name}:"+ret
      # end
      # 
      # def create_mailfrom_header(from, from_text)
      #   if from_text.blank?
      #     return "From: #{from}\n"
      #   else
      #     return to_mail_header("From", from_text).chomp + "<#{from}>\n"
      #   end
      # end
      # 
      # def create_subject_header(subject)
      #   to_mail_header("Subject",subject)
      # end
      # 
      # def create_mailto_header(to)
      #   if to.class.to_s == 'Array'
      #     return "To: #{to.join(',')}\n"
      #   else
      #     return "To: #{to.to_s}\n"
      #   end
      # end
    end
  end
end