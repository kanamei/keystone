#require 'redgreen'

gem 'term-ansicolor'
gem 'turn'
require 'test/unit'
require './lib/keystone/core_ext'
require './lib/keystone/core_ext/array'

class TestCoreExt < Test::Unit::TestCase
  def setup
  end

  def test_array_split_by
    assert_equal([1,2,3,4,5,6,7,8,9].split_by(3),[[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    assert_equal([1,2,3,4,5,6,7,8,9,10].split_by(2),[[1,2],[3,4],[5,6],[7,8],[9,10]])
    assert_equal([].split_by(3),[])
    assert_equal([[1,2,3,4],[1,23],[2,33],[[4]]].split_by(3),[[[1, 2, 3, 4], [1, 23], [2, 33]], [[[4]]]])
  end

  def test_array_left_join
    test1 = [{:a=>1,:b=>2}]
    test2 = [{:a=>2,:c=>3}]
    test3 = [{:a=>1,:c=>4},{:a=>2,:c=>6}]
    test4 = [{:a=>1,:b=>2,'test3_c'=>4}]
    test5 = [{:a=>1,:b=>2},{:a=>1,:b=>2}]
    test6 = [{:a=>1,:b=>2,'test3_c'=>4},{:a=>1,:b=>2,'test3_c'=>4}]
    test7 = [{:a=>1,:b=>2},{:a=>2,:b=>'test'}]
    test8 = [{:a=>1,:b=>2,'test3_c'=>4},{:a=>2,:b=>'test','test3_c'=>6}]

    ans = test1.left_join!(:test2,test2,:a,:a)
    assert_equal(ans,test1)
    ans = test1.left_join!(:test3,test3,:a,:a)
    assert_equal(ans,test4)
    ans = test7.left_join!(:test3,test3,:a,:a)
    assert_equal(ans,test8)

    test1 = []
    (0..300000).each do |i|
      has = {}
      [:a,:b,:c,:d,:e,:f,:g,:h].each do |k|
        has[k] = "#{k}#{i}"
      end
      has[:st] = '1' * 80
      test1 << has
    end

    test2 = []
    (0..300000).each do |i|
      has = {}
      [:a,:b,:c,:d,:e,:f,:g,:h].each do |k|
        has[k] = "#{k}#{i}"
      end
      has[:st] = '1' * 80
      test2 << has
    end

    puts Time.now
    puts test1.left_join!(:test2,test2,:a,:a)
    puts Time.now


  end
end
