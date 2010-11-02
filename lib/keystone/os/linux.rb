# -*- coding: utf-8 -*-
module Keystone::Os
  class Linux < Unix
    def self.get
      Dir.glob("/etc/*{-release,_version}").each do |file|
        content = File.open(file).read
        if content =~ /CentOS release (\d*)/
          os = Centos.new
          os.version = $1.to_i
          return os
        end
      end
      return Linux.new
    end
  end
end
