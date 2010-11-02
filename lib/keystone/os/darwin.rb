# -*- coding: utf-8 -*-
module Keystone
  module Os
    class Darwin < Unix
      def process_list
        `/bin/ps -aux`.chomp
      end
    end
  end
end