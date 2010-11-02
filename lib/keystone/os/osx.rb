# -*- coding: utf-8 -*-
module Keystone
  module Os
    class Osx < Darwin
      def ip_address
        ifconfig = `/sbin/ifconfig`
        ips = []

        # TODO mac
        ifconfig.gsub(/inet (\d+\.\d+\.\d+\.\d+) netmask/){|ip|
          if $1 != '127.0.0.1'
            ips << $1
          end
        }
        return ips
      end
    end
  end
end