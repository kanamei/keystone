require 'net/smtp'
require 'kconv'
require 'tempfile'
if __FILE__ ==$0
  $: << '../..'
  require 'keystone'
end

module Keystone
  module Mail
    # kopipe shimasita

    class KmContentType


  
    end

    class KmMessage
  
      include KmClassBase
  
      attr_accessor :header,:charset,:file_path,:file_name,
      attr_accessor :content_type,:body,:depth
      attr_accessor :file_handle,:file_stream,:is_header,
      attr_accessor :content_transfer_encoding,:messages,:is_finish_parsing
  
      def initialize(depth)
        @depth = depth
        @is_parsing_header = true
        @header = {}
        @body = ""
        @content_transfer_encoding = nil
        @messages = []
        @is_finish_parsing = false
        @last_header = nil
        $is_save_file = true
      end
  
      def set_parse_finish_messages
        @messages.each{|m|
          m.is_finish_parsing = true
          begin
            # TODO motitto iikannji
            m.file_stream.close
          rescue
          end
        }    
      end
  
      def parse(line)
        if @is_finish_parsing
          return false
        end
        line.chomp!
    
        if @is_parsing_header == true && line.strip == ""
          # header end
          @is_parsing_header = false
          reshape_header
          set_special_attrs
      
          @content_type = KmContentType.new(@header["content-type"])
          return true
        end

        if @is_parsing_header
          parse_and_set_header(line)
          return true
        else
          if @content_type.boundary != nil
            if line == "--#{@content_type.boundary}"
              set_parse_finish_messages
              @messages.push(KmMessage.new(@depth + 1))
              debug "new multipart start"
              return true
            end
            if line == "--#{@content_type.boundary}--"
              set_parse_finish_messages
              @is_finish_parsing = true
              debug "multipart end"
              if @file_handle != nil
                begin
                  @file_stream.close
                rescue => e
                  error e
                end
              end
              return true
            end
          end

          @messages.each{|message|
            if message.parse(line)
              return true
            end
          }
          return parse_and_set_body(line)
        end
      end
  
      def set_special_attrs
        # do not create file for top node KmMessage
        debug "depth=#{@depth}"
        if @depth != 1
          if @content_type.content_type != :multipart_mixed && @content_type.content_type != :multipart_related && @content_type.content_type != :multipart_alternative
            if $is_save_file
            debug "!!!!!!!! create file handle [content_type=#{@content_type.content_type}]"
              $save_folder ||= "/tmp"
              tmp_file = Tempfile.new("KmReceiveMail",$save_folder)
              @file_path = tmp_file.path
              @file_handle =tmp_file
              @file_stream =tmp_file.open        
              debug "@file_path=#{@file_path}"
            end
          end
        end
      end
  
      def reshape_header
    
        header["to"] = KmMailAddress::get_addresses(header["to"]) if header["to"] != nil
        header["cc"] = KmMailAddress::get_addresses(header["cc"]) if header["cc"] != nil
        header["return-path"] = KmMailAddress::get_addresses(header["return-path"])[0] if header["return-path"] != nil
        header["delivered-to"] = KmMailAddress::get_addresses(header["delivered-to"]) if header["delivered-to"] != nil
        header["from"] = KmMailAddress::get_addresses(header["from"])[0] if header["from"] != nil
    
        if @header["content-type"] != nil
          debug "reshape_header set content-type"
          @content_type = KmContentType.new(@header["content-type"])
          debug "@content_type=#{@content_type.inspect}"
          debug "get file"
        else
          warn "content-type not fond"
          warn @header.inspect
        end
        if @header["content-transfer-encoding"] != nil
          if /base64/i =~ @header["content-transfer-encoding"]
            @content_transfer_encoding = :base64
          elsif /7bit/i =~ @header["content-transfer-encoding"]
            @content_transfer_encoding = :_7bit
          elsif /8bit/i =~ @header["content-transfer-encoding"]
            @content_transfer_encoding = :_8bit
          elsif /binary/i =~ @header["content-transfer-encoding"]
            @content_transfer_encoding = :binary
          elsif /quoted\-printable/i =~ @header["content-transfer-encoding"]
            @content_transfer_encoding = :quoted_printable
          else
            error "transfer encoding not supported [#{@header["content-transfer-encoding"]}]"
          end
        end
      end
  
      def convert(data)
        return Kconv.toutf8(data)
      end
  
      def set_header(key,val)
        debug "key[#{key}],val[#{val}]"

        key = key.downcase
        @header[key] ||= ""
        if key == "subject"
          @header[key] += convert(val)
        elsif key == "received"
          @header[key] = [] if @header[key] == ""
          @header[key].push val
        else
          @header[key] += val
        end
      end
  
      def parse_and_set_header(line)
        if /^\s/ =~ line
          debug "multi header:#{@last_header}"
          set_header(@last_header,line.strip)
        else
      
          # harada 変更 2008/07/02
          #if /^(.*?):(.*)/ =~ line
          if /^(.*?):\s?(.*)/ =~ line
            @last_header = $1
            set_header($1,$2)
          else
            error "error parse header!! [#{line}]"
          end
        end
      end
  
      def parse_and_set_body(line)
    
        if @content_type.content_type == :text_plain || @content_type.content_type == :text_html
          cline = ""
          if @content_type.charset == :iso_2022_jp
            cline = convert(line)
          else
            cline = line
          end
      
          cline = "\n"+cline if @body != ""
    #      cline += "\n"
          @body += cline
          @file_stream.write(cline) if @file_handle != nil
        elsif @content_transfer_encoding == :base64
          debug "content_type=#{@content_type.content_type.to_s}"
          debug "boundary=#{@content_type.boundary}"
          debug "size=#{@file_handle.size}"
          debug "file_path=#{@file_path}"
          debug "!!!!!!!!!writing[#{line}]"
          @file_stream.write(Base64::decode64(line)) if @file_handle != nil
        end   
        return true
      end    
    end

    class Receive
  
      # @subject & @body is short cut to @message.###
      attr_reader :original
  
      def subject
        return @message.header["subject"]
      end
  
      def body_text_all
        @body_all = ""
        get_bodies(@message)
        return @body_all
      end

      def body_text_html
        # TODO 以下のプレーンテキストを集めたやつを帰す
        @body_all = ""
        get_bodies(@message,:text_html)
        return @body_all
      end

      def body_text_plain
        # TODO 以下のプレーンテキストを集めたやつを帰す
        @body_all = ""
        get_bodies(@message,:text_plain)
        return @body_all
      end

      def get_bodies(message,content_type = nil)
        if content_type == nil || message.content_type.content_type == content_type
          @body_all += message.body
        end
        message.messages.each{|m|
          get_bodies(m,content_type)
        }
      end
  
      def from
        return @message.header["from"]
      end

      def to
        return @message.header["to"]
      end
  
      def return_path
        return @message.header["return-path"]
      end
  
      def part_count
        i = [0]
        part_count_inner(@message,i)
        i[0]
      end
  
      def part_count_inner(message,i)
        i[0] += 1
        message.messages.each{|m|
          part_count_inner(m,i)
        }
      end
  
      def initialize(save_original = true)
        $KCODE = "u"
        @save_original = save_original
        @original = ""
        @message = KmMessage.new(1)
      end

      def parse(io_stream)
        while line = io_stream.gets
          @message.parse(line)
          if @save_original
            @original += line
          end
        end
      end
  
      def parse_from_file(file_path)
        open(file_path){|file|
          parse(file)
        }
      end
  
      def dump
        dump_inner(@message)
        info "=========== body =============="
        info(@message.body)
      end
  
      def dump_inner(message)
        info(("-" * message.depth) + "content-type=" + message.content_type.content_type.to_s)
        info(("-" * message.depth) + "boundary=" + message.content_type.boundary.to_s) if message.content_type.boundary != nil
        info(("-" * message.depth) + "file_path=" + message.file_path) if message.file_path != nil
        info(("-" * message.depth) + "content_transfer_encoding=" + message.content_transfer_encoding.to_s) if message.content_transfer_encoding != nil
        info(("-" * message.depth) + "header=" + message.header.inspect)
        message.messages.each{|m|
          dump_inner(m)
        }
      end
    end
  end
end

