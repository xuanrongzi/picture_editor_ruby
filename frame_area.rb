class FrameArea
  def initialize(x_min, y_min, x_max, y_max)
    @x_min,@y_min,@x_max,@y_max=x_min, y_min, x_max, y_max

  end
  def getMinX
    @x_min
  end
  def getMinY
    @y_min
  end
  def getMaxX
    @x_max
  end
  def getMaxY
    @y_max
  end
  def to_s
    "(#{@x_min},#{@y_min})::(#{@x_max},#{@y_max})"
  end

  # @param [FrameArea] new_frame_area
  def intersect(new_frame_area)
    if((@x_min>new_frame_area.getMaxX)||(@y_min>new_frame_area.getMaxY)||(@x_max<new_frame_area.getMinX)||(@y_max<new_frame_area.getMinY))
      raise Exception "There are no intersection"
    end
    x1=(@x_min>new_frame_area.getMinX)?@x_min:new_frame_area.getMinX
    x2=(@x_max>new_frame_area.getMaxX)?@x_max:new_frame_area.getMaxX
    y1=(@y_min>new_frame_area.getMinY)?@y_min:new_frame_area.getMinY
    y2=(@y_max>new_frame_area.getMaxY)?@y_max:new_frame_area.getMaxY
    FrameArea.new(x1,y1,x2,y2)

  end

  def translate (dx,dy)
    FrameArea.new(@x_min+dx,@y_min+dy,@x_max+dx,@y_max+dy)
  end
end