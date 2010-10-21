require 'tempfile'

class Tempfile
  def self.open_with_block(name = nil, dir = nil)
    name ||= (0..8).map{rand(36).to_s(36)}.join
    args = dir ? [name, dir] : [name]
    tmp = Tempfile.open *args
    begin
      yield tmp
    ensure
      tmp.close true
    end
  end
end