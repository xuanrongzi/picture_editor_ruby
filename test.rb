require_relative 'pixel'
require_relative 'frame'
require_relative 'frame_area'
require_relative 'indirect_frame'
class Test
  a=Frame.new(4,4,Pixel.new(1,2,3),"Piazza")

  a.render
  b=IndirectFrame.new(a,1,0,2,2)
  c=IndirectFrame.new(a,0,1,2,2)
  print b.equal?c

  b.each{|x| print x}
  b[1,1].r=12
  b[0,1]=Pixel.new(5,5,5)
  b.render
  d=b.separate
  d[1].render


end