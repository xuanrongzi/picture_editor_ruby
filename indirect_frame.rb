class IndirectFrame
  # @param [Frame] frame_source
  def initialize(frame_source, x_offset, y_offset, height, width)
    @source=frame_source
    @x_off, @y_off, @height, @width=x_offset, y_offset, height, width
    raise Exception "Indirect Frame out bound" if (@x_off+@height>@source.height)||(@y_off+@width>@source.width)
  end

  def title
    "Indirect Frame of"+@source.title
  end
  def title=(t)
    @source.title=t if (t!=nil)|(t.is_a?String)
  end

  # @param [Frame] new_frame
  def equal?(new_frame)
    if((new_frame.is_a?IndirectFrame)||(new_frame.is_a?Frame))
      if(new_frame.width==@width&&new_frame.height==@height)

        0.upto(@height-1)do |i|
          0.upto(@width-1)do |j|
            return false if(@source[@x_off+i,@y_off+j].rgb!=new_frame[i,j].rgb)
          end
        end
        return true
      end

    end
    false
  end

  def to_s
    "Indirect Frame: #{@title}(Height:#{@height},Width:#{@width}) with original frame titled: #{@source.title}.\n"
  end

  def each
    0.upto(@height-1)do |i|
      0.upto(@width-1)do |j|
        yield @source[@x_off+i,@y_off+j]
      end
    end

  end

  # noinspection RubyArgCount
  def separate
    #divided the frame into r frame, g frame and b frame
    frame_r=Frame.new(@height, @width, Pixel.new(0,0,0),@source.title+"_r")
    frame_g=Frame.new(@height, @width, Pixel.new(0,0,0),@source.title+"_g")
    frame_b=Frame.new(@height, @width, Pixel.new(0,0,0),@source.title+"_b")

    0.upto(@height-1) do |i|
      0.upto(@width-1) do |j|
        a=@source[@x_off+i,@y_off+j].rgb
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
    @source[@x_off+row,@y_off+col]
  end
  alias get []

  def []=(row,col,pixel)
    if   !(pixel.instance_of?Pixel)
      return nil
    end
    @source[@x_off+row,@y_off+col]=pixel if ((row>=0)|(col>=0)|(row<@height)|(col<@width))
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
    print "Below listed the elements in the graph: #{@source.title} \n"
    0.upto(@width-1)do |j|
      0.upto(@height-1)do |i|
        print '%03d,%03d,%03d  ' %[@source[@x_off+i,@y_off+j].r,@source[@x_off+i,@y_off+j].g,@source[@x_off+i,@y_off+j].b]
      end
      print "\n"
    end
  end

end