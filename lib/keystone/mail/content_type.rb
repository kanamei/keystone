# -*- coding: utf-8 -*-
require 'net/smtp'

if __FILE__ ==$0
  $: << '../..'
  require 'keystone'
end

module Keystone
  module Mail
    class ContentType
      attr_accessor :content_type,:charset,:boundary
      def initialize(st)
        if /text\/plain/i =~ st
          @content_type = :text_plain
          if /charset="?iso-2022-jp"?/i =~ st
            @charset = :iso_2022_jp
          elsif /charset="?utf-8"?/i =~ st
            @charset = :utf_8
          end
        elsif /multipart\/mixed/i =~ st
          @content_type = :multipart_mixed
          @boundary = get_boundary(st)
        elsif /multipart\/related/i =~ st
          @content_type = :multipart_related
          @boundary = get_boundary(st)
        elsif /multipart\/alternative/i =~ st
          @content_type = :multipart_alternative
          @boundary = get_boundary(st)
        elsif /text\/html/i =~ st
          @content_type = :text_html
          if /charset="?iso-2022-jp"?/i =~ st
            @charset = :iso_2022_jp
          elsif /charset="?utf-8"?/i =~ st
            @charset = :utf_8
          end
        else
          if /image\/(?:jpeg|jpg)/i =~ st
              @content_type = :image_jpeg
          elsif /image\/png/i =~ st
            @content_type = :image_png
          elsif /image\/gif/i =~ st
            @content_type = :image_gif
          else
            throw "this image does not support[#{st}]"
          end
        end
      end
  
      def get_boundary(st)
        # TODO  modify regular expression 
          if /boundary="(.*)"/i =~ st
            return $1
          elsif /boundary=(.*)/i =~ st
            return $1
          end
          return nil
      end
    end
  end
end