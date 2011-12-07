# -*- coding: utf-8 -*-

#$KCODE = 'u'


unless RUBY_VERSION == '1.9.2' || RUBY_VERSION == '1.9.3'
  # version check
  raise 'this version only for 1.9.2 or 1.9.3' 
end

require 'keystone/core_ext'
require 'keystone/base'

include Keystone::Base

autoload :FlagSetMaker  , 'vendor/flag_set_maker'
autoload :Moji          , 'vendor/moji'

module Keystone

  VERSION = '0.0.32'

  autoload :StringUtil , 'keystone/string_util'
  autoload :Batch      , 'keystone/batch'
  autoload :Os         , 'keystone/os'
  autoload :Mail       , 'keystone/mail'
 
  module Rails
    #autoload :ActiveSupportExt, 'keystone/rails/active_support_ext'
  end
end

