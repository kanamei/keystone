require 'rubygems'
require 'redgreen'
require 'lib/keystone/core_ext'

class TestCoreExt < Test::Unit::TestCase
  def setup
  end  
  
  def test_array_split_by
    assert_equal([1,2,3,4,5,6,7,8,9].split_by(3),[[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    assert_equal([1,2,3,4,5,6,7,8,9,10].split_by(2),[[1,2],[3,4],[5,6],[7,8],[9,10]])
    assert_equal([].split_by(3),[])
    assert_equal([[1,2,3,4],[1,23],[2,33],[[4]]].split_by(3),[[[1, 2, 3, 4], [1, 23], [2, 33]], [[[4]]]])
  end
end