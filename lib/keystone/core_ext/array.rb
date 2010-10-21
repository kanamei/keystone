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
end