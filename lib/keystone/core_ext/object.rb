# -*- coding: utf-8 -*-
class Object
  # http://www.yohasebe.com/pages/trans-seeing-metaclasses-clearly/
  def metaclass
    class << self
      self
    end
  end
 
  # http://www.yohasebe.com/pages/trans-seeing-metaclasses-clearly/
  def meta_eval(&blk)
    metaclass.instance_eval(&blk)
  end
 
  # http://www.yohasebe.com/pages/trans-seeing-metaclasses-clearly/
  def meta_def(name, &blk)
   meta_eval { define_method name, &blk }
  end
 
  # http://www.yohasebe.com/pages/trans-seeing-metaclasses-clearly/
  def class_def(name, &blk)
    class_eval { define_method name, &blk }
  end
  
  # 1.8.7  エミュレート
  # TODO version 指定
  # def tap
  #   yield(self)
  #   self
  # end
  # 
  def tapp
    self.tap{|obj| p obj}
  end
end
