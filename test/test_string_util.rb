require 'rubygems'
require 'redgreen'
require 'vendor/flag_set_maker'
require 'vendor/moji'
require 'lib/keystone/string_util'

$KCODE='u'

class TestStringUtilBase < Test::Unit::TestCase
  def setup
  end  
  
  def test_reverse_mail
    assert_equal(Keystone::StringUtil::reverse_mail_address("testuser@softbank.ne.jp"),"jp.ne.softbank@testuser")
    assert_equal(Keystone::StringUtil::reverse_mail_address("test.user@somedomain.com"),"com.somedomain@test.user")
    assert_equal(Keystone::StringUtil::reverse_mail_address("a.b@c.d"),"d.c@a.b")
    assert_equal(Keystone::StringUtil::reverse_mail_address("a.b@"),"@a.b")
    assert_equal(Keystone::StringUtil::reverse_mail_address("@c.d"),"d.c@")
    assert_equal(Keystone::StringUtil::reverse_mail_address("a.b"),"a.b")
  end
  
  def test_int_to_splitted_path
    assert_equal(Keystone::StringUtil.int_to_splitted_path(113355,12,"/tmp",".jpg"),"/tmp/000/000/113/355.jpg")
    assert_equal(Keystone::StringUtil.int_to_splitted_path(1234567890,10,"/temp",".png"),"/temp/1/234/567/890.png")
    assert_equal(Keystone::StringUtil.int_to_splitted_path(1234567890,11,"/temp",".png"),"/temp/01/234/567/890.png")
    assert_raise(RangeError){Keystone::StringUtil.int_to_splitted_path(12345678901,10,"/tmp")}
    assert_equal(Keystone::StringUtil.int_to_splitted_path(00000000000000001,11,"/tmp",".gif"),"/tmp/00/000/000/001.gif")
  end
  
  def test_serach_string_to_array
    assert_equal(Keystone::StringUtil.serach_string_to_array(%|test test2 test3|),%w|test test2 test3|)
    assert_equal(Keystone::StringUtil.serach_string_to_array(%|test "test2" test3|),%w|test test2 test3|)
    assert_equal(Keystone::StringUtil.serach_string_to_array(%|test "test 2" test3|),["test","test 2","test3"])
    assert_equal(Keystone::StringUtil.serach_string_to_array(%|"test 1" "test 2" test3|),["test 1","test 2","test3"])
    assert_equal(Keystone::StringUtil.serach_string_to_array(%|"日本語 1" "test 2" test3|),["日本語 1","test 2","test3"])
    assert_equal(Keystone::StringUtil.serach_string_to_array(%|"日本語 1" "test 2" ﾊﾝｶｸ|),["日本語 1","test 2","ﾊﾝｶｸ"])
    # TODO 
    # assert_equal(Keystone::StringUtil.serach_string_to_array(%|"日本語 1" "tes\"t 2" ﾊﾝｶｸ|),["日本語 1","test 2","ﾊﾝｶｸ"])
  end
  
  def test_to_searchtext
    assert_equal(Keystone::StringUtil.to_searchtext("日本語"),"日本語")
    assert_equal(Keystone::StringUtil.to_searchtext("カタカナ"),"カタカナ")
    assert_equal(Keystone::StringUtil.to_searchtext("ﾊﾝｶｸ"),"ハンカク")
    assert_equal(Keystone::StringUtil.to_searchtext("A"),"a")
    assert_equal(Keystone::StringUtil.to_searchtext("１"),"1")
    assert_equal(Keystone::StringUtil.to_searchtext("ａｂＣＤ１２３４"),"abcd1234")
    assert_equal(Keystone::StringUtil.to_searchtext("スープ"),"スープ")
    assert_equal(Keystone::StringUtil.to_searchtext("ｽｰﾌﾟ"),"スープ")  # ハンカク半濁点
    assert_equal(Keystone::StringUtil.to_searchtext("ｺｽﾞﾐｯｸﾗﾅｳｪｲ"),"コズミックラナウェイ")  # ハンカク濁点
    assert_equal(Keystone::StringUtil.to_searchtext("ー―－‐"),"ー―-‐")  # ハンカク濁点
    
    
    
    # TODO
    assert_equal(Keystone::StringUtil.to_searchtext("！”＄％＆￥’（）＊＋，－．／：；＜＝＞？＠［￥］＾＿‘｛｜｝～＃"),"!\"$%&\\'()*+,-./:;<=>?@[\\]^_`{|}~#") # 半角全角変換可能記号
    assert_equal(Keystone::StringUtil.to_searchtext("｡｢｣､ｰﾞﾟ･"),"。「」、ー゛゜・")
    assert_equal(Keystone::StringUtil.to_searchtext("ⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩ"),"ⅰⅱⅲⅳⅴⅵⅶⅷⅸⅹ")
  end
end