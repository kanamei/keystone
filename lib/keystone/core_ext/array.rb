# -*- coding: utf-8 -*-
class Array
  #
  # TODO 
  # active_supportに同様のメソッドが無いかどうかの確認
  #
  def split_by(num)
    return [] if self.size < 1
    ret = [[]]
    counter = 0
    self.each do |val|
      (counter = 0;ret << []) if counter >= num
      ret[-1] << val
      counter += 1
    end
    return ret
  end

  if RUBY_VERSION < '1.8.7'
    def sample(count=1)
      if count == 1
        return at( rand( size ) )
      elsif count < 1
        return nil
      else
        return sort_by{rand}[0..count-1]
      end
    end
  end

  #
  # 候補が実は複数あるときはエラーを出したいが、、、今のところ無しで
  #
  def left_join!(name,ar,index1,index2)

    key_hits = []
    has = {}
    ar.each do |o|
      if o.has_key?(index2)
        val = o[index2]
        if key_hits.include?(val)
          raise "right side data is multiple(#{val})"
        end
        h = o.clone
        h.delete(index2)
        has[val] = h
      end
    end

    self.each do |i|
      if has.has_key?(i[index1])
        has[i[index1]].each do |key,value|
          i["#{name.to_s}_#{key}"] = value
        end
      end
    end
    self
  end
end
