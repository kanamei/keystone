require 'net/smtp'

if __FILE__ ==$0
  $: << '../..'
  require 'keystone'
end

module Keystone
  module Mail
    class Address
        attr_accessor :name,:address

        def initialize(name,address)
          @name = name
          @address = address
        end

        def KmMailAddress::get_addresses(line)
          ret = []
          addrs = line.to_s.split(',')
          addrs.each{|item|
            addr,name = parse_mail_address(item)
            ret.push(KmMailAddress.new(name,addr))
          }
          return ret
        end

        def KmMailAddress::parse_mail_address(line)
          # =?ISO-2022-JP?B?GyRCODZFRCVGJTklSBsoQg==?= <harada@kanamei.co.jp>
          # test@mail-ko2.kanamei.co.jp
          # <orz@softbank.ne.jp>
          # "=?ISO-2022-JP?B?GyRCNjZLXBsoQg==?=" <hashimoto@kanamei.co.jp>

          #=?ISO-2022-JP?B?GyRCODZFRCQ5JDIhPCE8ITwhPCE8ITwhPCE8ITwhPCE8ITwhPBsoQg==?=
          #=?ISO-2022-JP?B?GyRCITwhPCE8ITwhPCE8ITwhPCE8ITwhPCE8ITwhPCE8ITwhPCE8GyhC?=
          #=?ISO-2022-JP?B?GyRCITwhPCE8ITwhPCE8ITwhPCE8ITwhPCE8ITwhPCE8ITwhPCE8GyhC?=
          #=?ISO-2022-JP?B?GyRCITwhPCE8ITwhPCE8ITwkSiQsJCRGfEtcOGxMPhsoQkZ1Y2sbJEIlRhsoQg==?=
          #=?ISO-2022-JP?B?GyRCJTklSBsoQg==?= <harada@kanamei.co.jp>, 
          #test@mail-ko2.kanamei.co.jp

          #"=?ISO-2022-JP?B?GyRCJEokLCE8ITwhPCE8ITwhPCE8GyhC?= =?ISO-2022-JP?B?GyRCITwhPCE8ITwhPCE8ITwhPCE8ITwbKEI=?= =?ISO-2022-JP?B?GyRCITwkJEw+QTAlRiU5JUgkJiQyGyhC?= =?ISO-2022-JP?B?GyRCITwhPCE8ITwhPCRKJHMkLiRkJE0bKEI=?=" <test@mail-ko2.kanamei.co.jp>
          #"=?UTF-8?B?44Gq44GM44O844O844O844O844O844O844O844O844O8?==?UTF-8?B?44O844O844O844O844O844O844O844O844O844O844O8?==?UTF-8?B?44O844O844O844O844O844O844O844O844O844O844O8?==?UTF-8?B?44O844O844O844O844O844O844O844O844O844O844O8?==?UTF-8?B?44O844O844O844O844O844O844O844O844O844O844O8?==?UTF-8?B?44O844O844O844O844O844GE44GC44Gm5YWI?=

          name,address = ""
          KmClassBase::debug "line=#{line}"

          if /"(.*)"\s*<(.*)>/ =~ line
            # umaku dekinkatta
            name = $1.strip
            address = $2.strip
            KmClassBase::debug "name=|#{name}|"
          elsif /(.*)\s*<(.*)>/ =~ line
            name = $1.strip
            address = $2.strip
            KmClassBase::debug "name=|#{name}|"
            KmClassBase::debug "address=|#{address}|"
          else
            address = line.strip
          end

      #    if /^=\?ISO-2022-JP.*/i =~ name || 
      #    if /^=\?UTF-8/i =~ name
          if /^(?:(=\?ISO-2022-JP\?B\?)|(=\?UTF-8\?B\?))/i =~ name
            KmClassBase::debug "hit!!"
            begin
              KmClassBase::debug "hit #{$1}"
              name = KmMailAddress::convert(name)
            rescue => e
              KmClassBase::warn e.to_s
            end
          end

          KmClassBase::debug "name_end=|#{name}|"
          KmClassBase::debug "address_end=|#{address}|"
          return address,name
        end  

        # TODO 場所考える（今二個ある）
        def KmMailAddress::convert(data)
          return Kconv.toutf8(data)
        end

        def self.create_reverse_mail_address(mail_addr)
          puts mail_addr
          m = mail_addr.dup.strip
          puts "|#{m}|"
          ar = m.split("@")
          return ar[1].split(".").reverse.join(".") +"@"+ ar[0]
        end      
    end
  end
end