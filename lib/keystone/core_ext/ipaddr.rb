# -*- coding: utf-8 -*-
require 'ipaddr'

class IPAddr
  def to_a
    begin_addr = (@addr & @mask_addr)
    case @family
    when Socket::AF_INET
      end_addr = (@addr | (IN4MASK ^ @mask_addr))
    when Socket::AF_INET6
      end_addr = (@addr | (IN6MASK ^ @mask_addr))
    else
      raise "unsupported address family"
    end
    ret = []
    begin_addr.upto(end_addr){|addr| ret << IPAddr.new(addr,Socket::AF_INET)}
    return ret
  end
end