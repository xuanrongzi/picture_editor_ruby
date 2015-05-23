require_relative 'pixel'
class Frame
  include Enumerable
  def initialize(*args)
    @height,@width=args[0],args[1]
    case args.length
      when 2
        @ini_color=Pixel.new(0,0,0)
      when 3
        @ini_color=args[2]
      else
        raise Error, 'Frame only receive 2 or 3 parameters'
    end
    @title=''
    make_frame
  end

  def make_frame
    row,col=@height,@width
    @frame=Array.new(row)
    @frame.map! { Array.new(col) }

    0.upto(@height-1) do |i|
      0.upto(@width-1) do |j|
        @frame[i][j]=Pixel.new(*@ini_color.rgb)
      end
    end
  end

  def title
    @title
  end
  def title=(t)
    @title=t if (t!=nil)|(t.is_a?String)
  end

  # @param [Frame] new_frame
  def equal?(new_frame)
    if(new_frame.is_a?Frame)
      if(new_frame.width==@width&&new_frame.length==@length)

        0.upto(@height-1)do |i|
          0.upto(@width-1)do |j|
            return nil if(!(@frame[i][j].rgb==new_frame[i][j].rgb))
          end
        end
      end
        return true
    end
     nil
  end

  def to_s
    "Frame: #{@title}(Height:#{@height},Width:#{@width})"
  end

  def each

    0.upto(@height-1)do |i|
      0.upto(@width-1)do |j|
        yield @frame[i][j]
      end
    end

  end

  def separate
    #divided the frame into r frame, g frame and b frame
    frame_r=Array.new(@height){Array.new(@width)}
    frame_g=Array.new(@height){Array.new(@width)}
    frame_b=Array.new(@height){Array.new(@width)}
    0.upto(@height-1) do |i|
      0.upto(@width-1) do |j|
          a=@frame[i][j].rgb
          frame_r[i][j]=Pixel.new(a[0],0,0)
          frame_g[i][j]=Pixel.new(0,a[1],0)
          frame_b[i][j]=Pixel.new(0,0,a[2])
      end
    end
  [frame_r,frame_g,frame_b]
  end

  def get(row,col)
    @frame[row][col]
  end

  def [](row, col)
    if (row<0)|(col<0)|(row>=@height)|(col>=@width)
      return nil
    end
    @frame[row][col]
  end

  def []=(row,col,pixel)
    if   !(pixel.instance_of?Pixel)
          return nil
    end
    @frame[row][col]=pixel if ((row>=0)|(col>=0)|(row<@height)|(col<@width))
  end
  alias put []=

  def width
    @width
  end
  def height
    @height
  end
  alias h height
  alias w width



  a=Frame.new(3,3,Pixel.new(1,2,3))
  a[1,1]=Pixel.new(1,1,1)
  a[1,0]=Pixel.new(2,2,2)
  a[0,1].r=11
  a[0,0].r=10
  a[2,2]=a[1,1]
  print  a.get(1,1)
  print "--\n"

  Pixel.new(25,1,1)
  a.each{|x| print x}
end