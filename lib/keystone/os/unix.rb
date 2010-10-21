module Keystone
  module Os
    class Unix < AbstractOs
      def ip_address
        ifconfig = `/sbin/ifconfig`
        ips = []

        # TODO mac
        ifconfig.gsub(/inet addr:(\d+\.\d+\.\d+\.\d+)/){|ip|
          if $1 != '127.0.0.1'
            ips << $1
          end
        }
        return ips
      end

      def bin_or_usrbin(cmd,option="")
        cmd_option = "#{cmd} #{option}"
        begin;return `/bin/#{cmd_option}` if File.exists?("/bin/#{cmd}");rescue;end
        begin;return `/usr/bin/#{cmd_option}` if File.exists?("/usr/bin/#{cmd}");rescue;end
        begin;return `/sbin/#{cmd_option}` if File.exists?("/sbin/#{cmd}");rescue;end
        begin;return `/usr/sbin/#{cmd_option}`.chomp;rescue;end
      end

      def hostname
        bin_or_usrbin("hostname")
      end

      def disk
        bin_or_usrbin("df","-h")
      end

      def process_list
        bin_or_usrbin("ps","-aux")
      end

      def netstat
        bin_or_usrbin("netstat","-an")
        `/usr/sbin/netstat -an`.chomp
      end
    end
  end
end