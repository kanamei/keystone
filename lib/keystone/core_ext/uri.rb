# -*- coding: utf-8 -*-
class Uri
  #
  def self.escape_raw(st)
    st.gsub(/([^a-zA-Z0-9_\-\.~])/) { "%#{$1.unpack('H*')[0].scan(/../).join('%').upcase }" }
  end

  #
  # usage
  # @search_tag = Uri.unescape_raw(params[:tag]).toutf8
  #
  def self.unescape_raw(st)
    st.tr('+',' ').gsub(/%([A-Fa-f0-9][A-Fa-f0-9])/) { [$1.hex].pack('C') }
  end
end