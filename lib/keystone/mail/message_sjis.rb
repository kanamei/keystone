# -*- coding: utf-8 -*-
require 'kconv'

module Keystone
  module Mail
    #
    # encoding 未実装
    #
    #
    class MessageSjis < Keystone::Mail::Message
      def encode_mime(st)
        Kconv.tosjis(st)
      end
      
      def mime_header_string
        "=?ShiftJIS?B?"        
      end      

      def encode_body
        Kconv.tosjis(@body)
      end      
    end
  end
end
