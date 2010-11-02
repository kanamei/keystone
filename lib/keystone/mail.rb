# -*- coding: utf-8 -*-
module Keystone::Mail
  autoload :Message,          'keystone/mail/message'
  autoload :MessageIso2022jp, 'keystone/mail/message_iso2022jp'
  autoload :MessageSjis,      'keystone/mail/message_sjis'
  autoload :Receive,          'keystone/mail/receive'
  autoload :MessageFactory,   'keystone/mail/message_factory'
  autoload :Send,             'keystone/mail/send'
end
