
$KCODE = 'u'

require 'keystone/core_ext'
require 'keystone/base'

include Keystone::Base

autoload :FlagSetMaker  , 'vendor/flag_set_maker'
autoload :Moji          , 'vendor/moji'

module Keystone

  VERSION = '0.0.27'

  autoload :StringUtil , 'keystone/string_util'
  autoload :Batch      , 'keystone/batch'
  autoload :Os         , 'keystone/os'
  autoload :Mail       , 'keystone/mail'
 
  module Rails
    #autoload :ActiveSupportExt, 'keystone/rails/active_support_ext'
  end
end

