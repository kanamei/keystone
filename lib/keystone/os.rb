require 'keystone/os/abstract_os'

module Keystone::Os
  autoload :Centos,  'keystone/os/centos'
  autoload :Linux,   'keystone/os/linux'
  autoload :Darwin,  'keystone/os/darwin'
  autoload :Osx,     'keystone/os/osx'
  autoload :Unix,    'keystone/os/unix'
  # autoload :Windows, 'keystone/env/windows.rb' # fu*k windows
  def self.oses
    @oses ||= constants
  end
  
  def self.get
    case RUBY_PLATFORM
    when /linux/
      # TODO only centos impremented
      Keystone::Os::Linux.get()
    when /darwin/
      # TODO only osx impremented
      Keystone::Os::Osx.new
    else
      # TODO
    end
  end
end
