require_relative 'pixel'
class Frame
  def initialize(*args)
    @height,@width=args[0],args[1]
    case args.length
      when 2
        @ini_color=Pixel.new(0,0,0)
      when 3
        @ini_color=args[2]
      else
        raise Invaild, 'Frame only receive 2 or 3 parameters'
    end
    make_frame
  end

  def make_frame
    row,col=@height,@width
    @frame=Array.new(row)
    @frame.map!{Array.new(col,@ini_color.clone)}

  end

  def get(row,col)
    @frame[row][col]
  end

  def put(row,col,pixel)
    @frame[row][col]=pixel if pixel.instance_of? Pixel
  end

  def width
    @width
  end
  def height
    @height
  end
  alias h height
  alias w width



  a=Frame.new(2,2)
  a.put(1,1,Pixel.new(5,3,4))
  a.put(1,1,1)
  print  a.get(1,1)
end