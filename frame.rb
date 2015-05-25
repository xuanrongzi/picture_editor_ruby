require_relative 'pixel'
class Frame
  include Enumerable
  def initialize(*args)
    #input value should be .new(height, width, ini_color, "title") pattern or omit color
    @title=''
    @height,@width=args[0],args[1]
    case args.length
      when 2
        @ini_color=Pixel.new(0,0,0)
      when 3
        @ini_color=args[2]
      when 4
        @title=args[3]
        @ini_color=args[2]
      else
        raise Exception 'Frame only receive 2 to 4 parameters'
    end

    make_frame(@height,@width)
  end

  def make_frame(h,w)
    row,col=h,w
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
      if(new_frame.width==@width&&new_frame.height==@height)

        0.upto(@height-1)do |i|
          0.upto(@width-1)do |j|
            return false if(@frame[i][j].rgb!=new_frame[i,j].rgb)
          end
        end
        return true
      end

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
    frame_r=Frame.new(@height, @width, Pixel.new(0,0,0),@title+"_r")
    frame_g=Frame.new(@height, @width, Pixel.new(0,0,0),@title+"_g")
    frame_b=Frame.new(@height, @width, Pixel.new(0,0,0),@title+"_b")

    0.upto(@height-1) do |i|
      0.upto(@width-1) do |j|
          a=@frame[i][j].rgb
          frame_r[i,j]=Pixel.new(a[0],0,0)
          frame_g[i,j]=Pixel.new(0,a[1],0)
          frame_b[i,j]=Pixel.new(0,0,a[2])
      end
    end
   return [frame_r,frame_g,frame_b]
  end



  def [](row, col)
    if (row<0)|(col<0)|(row>=@height)|(col>=@width)
      return nil
    end
    @frame[row][col]
  end
  alias get []

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

  def get_Average
    r=g=b=0.0
    self.each do |x|

      r+=x.r
      g+=x.g
      b+=x.b
    end
    r=r/(@width*@height)
    g=g/(@width*@height)
    b=b/(@width*@height)
    #Pixel.new(r,g,b)
    '%3.4f,%3.4f,%3.4f\n' %[r,g,b]
  end

  def render
    print "Below listed the elements in the graph: #{@title} \n"
    0.upto(@width-1)do |j|
      0.upto(@height-1)do |i|
        print '%03d,%03d,%03d  ' %[@frame[i][j].r,@frame[i][j].g,@frame[i][j].b]
      end
      print "\n"
    end
  end


end