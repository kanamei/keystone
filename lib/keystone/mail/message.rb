require 'kconv'

module Keystone
  module Mail
    class Message
      attr_accessor :subject, :body, :mail_to, :mail_from, :mail_from_text

      #
      # 普通なことをしたいならTMailを使いましょう
      #
      def initialize(opt={})
        @subject, @body, @mail_from_text = "", "", nil
        set_option(opt)
      end

      def to_src
        header = ""
        header += "Date: #{time2str(Time.now)}\n"
        header += create_mailfrom_header
        header += create_mailto_header
        header += create_subject_header
        header += "\n"
        header += encode_body
        return header
      end
      
      def set_option(opt)
        @subject = opt[:subject] if opt.key?(:subject)
        @body = opt[:body] if opt.key?(:body)
        @body = opt[:mail_to] if opt.key?(:mail_to)
        @body = opt[:mail_from] if opt.key?(:mail_from)
        @mail_from_text = opt[:mail_from_text] if opt.key?(:mail_from_text)
      end
      
      private
      
      # from tmail
      WDAY = %w( Sun Mon Tue Wed Thu Fri Sat KeystoneBUG )
      MONTH = %w( TMailBUG Jan Feb Mar Apr May Jun
                           Jul Aug Sep Oct Nov Dec KeystoneBUG )
      def time2str( tm )
        # [ruby-list:7928]
        gmt = Time.at(tm.to_i)
        gmt.gmtime
        offset = tm.to_i - Time.local(*gmt.to_a[0,6].reverse).to_i

        # DO NOT USE strftime: setlocale() breaks it
        return sprintf('%s, %s %s %d %02d:%02d:%02d %+.2d%.2d',
                WDAY[tm.wday], tm.mday, MONTH[tm.month],
                tm.year, tm.hour, tm.min, tm.sec,
                *(offset / 60).divmod(60))
      end      
      
      def create_mailfrom_header
        if @mail_from_text.blank?
          return "From: #{@mail_from}\n"
        else
          return to_mail_header("From", @mail_from_text).chomp + "<#{@mail_from}>\n"
        end        
      end
      
      def create_subject_header
        to_mail_header("Subject",@subject)
      end
      
      def create_mailto_header
        if @mail_to.kind_of?(Array)
          return "To: #{@mail_to.join(',')}\n"
        else
          return "To: #{@mail_to.to_s}\n"
        end
      end
      
      def encode_mime
        raise "mime_encode must be implemented!!"
      end
      
      def encode_body
        raise "encoded_body must be implemented!!"
      end
      
      def mime_header_string
        raise "mime_header_string must be implemented!!"
      end

      private

      def to_mail_header(header_name, plain_text)
        ret = ""
        str = plain_text.clone
        str.gsub!(/(\r|\n)/,"")
        str.split(//).split_by(10).each do |ar|
          st = encode_mime(ar.join(''))
          st = st.split(//,1).pack('m')
          st = st.chomp
          ret += " #{mime_header_string}#{st}?=\n"   
        end
        return "#{header_name}:"+ret
      end
    end
  end
end
