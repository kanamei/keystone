module Keystone
  module Mail
    class MessageFactory
      def self.create(opt)
        message = MessageIso2022jp.new(opt)
        if opt.key?(:encoding)
          case opt[:encoding]
          when :sjis
            message = MessageSjis.new(opt)
          else
            raise "encoding '#{opt[:encoding]}' is not supported"
          end
        end
        return message
      end
    end
  end
end