# -*- coding: utf-8 -*-
module Keystone
  #
  # ログレベルに関してのローカルルール（ログ確認に関して）
  # debug    対応不要
  # info     対応不要
  # warn     複数個で営業時間内対応
  # notice   1つで営業時間内対応
  # error    1つで営業時間内対応
  # alert    複数個で即時対応
  # critical 1つで即時対応
  #
  module Base
    def self.included(base)
      def __logger
        Keystone::Base::Logger.instance
      end

      base.class_eval do
        def self.logger_name(name)
          if self.respond_to?(name)
            raise "name #{name} can not set!!"
          end
          define_method(name, instance_method(:__logger))
        end
      end
    end
    
    class Logger
      def self.instance
        @@looger_instance ||= Keystone::Base::Logger.new
        return @@looger_instance
      end
      
      def _log(log_type,message, is_base_info = true)

        # ......nangiyana
        message.gsub!(/\r\n/,"\n")
        message.gsub!(/\r/,"\n")

        messages = message.split("\n")
        if messages.size > 1
          messages.each_with_index do |st,i|
            next if st == ""
            if i == 0
              puts "[#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}][#{$$}][#{log_type.to_s}] #{st}"
            else
              puts "[#{log_type.to_s}] #{st}"
            end
          end
        else
          if message != ""
            if is_base_info
              puts "[#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}][#{$$}][#{log_type.to_s}] #{message}"
            else
              puts "[#{log_type.to_s}] #{message}"
            end
          end
        end
      end

      def error(message)
        if message.is_a? Exception
          _log(:ERROR,"#{message.message}")
          message.backtrace.each_with_index {|line, i|
            _log(:ERROR,"#{line})",false)
          }
        else
          _log(:ERROR,message.to_s)
        end
      end

      def info(message)
        _log(:INFO,message)
      end

      def warn(message)
        _log(:WARN,message)
      end

      def notice(message)
        _log(:NOTICE,message)
      end

      def alert(message)
        _log(:ALERT,message)
      end    

      def critical(message)
        _log(:CRIT,message)
      end    

      def debug(message)
        if $DEBUG
          _log(:DEBUG,message)
        end
      end
    end
  end
end
