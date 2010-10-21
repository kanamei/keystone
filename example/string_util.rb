require 'rubygems'
require 'keystone'

st = %|test "test 02" 日本語 ﾆﾎﾝｺﾞﾊﾝｶｸ "にほ　んご　ですが　なにか"|
st2 = Keystone::StringUtil.to_searchtext(st)

p Keystone::StringUtil.serach_string_to_array(st)
p Keystone::StringUtil.serach_string_to_array(st2)

info("test")
info("test\ntest2")
info("test\r\ntest2")
warn("test\rtest2")
error("test\ntest2")
info("test")
