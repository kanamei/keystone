module Keystone
  module Os
    class AbstractOs
      
      attr_accessor :version
      
      def ip_address
      end

      def hostname
      end

      def disk
      end

      def process_list
      end

      def netstat
      end

      def dump
        self_methods = self.methods - Class.methods
        self_methods.delete("version=")
        self_methods.delete("dump")
        self_methods.delete("bin_or_usrbin")
        st = ""
        self_methods.each do |method|
          p method
          st << "== #{method} ==\n  #{self.__send__(method).to_s.split("\n").join("\n  ")}\n"
        end
        return st
      end
    end
  end
end