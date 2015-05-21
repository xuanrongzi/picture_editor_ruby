class Pixel

  def initialize(red,green,blue)
    if (red.is_a?Fixnum)&& (green.is_a?Fixnum) &&(blue.is_a?Fixnum)

      @red, @green, @blue=red, green, blue
    else
      raise Invalid, "Wrong type for Pixel"
    end
    if (red>255)|(red<0)|(green>255)|(green<0)|(blue>255)|(blue<0)
      raise Invalid,  "Color Out of Bound, #{red},#{green}, #{blue}"
    end
    @brightness=0.2126 * red + 0.7152 * green + 0.0722 * blue
  end


  def rgb()
    return[@red,@green,@blue]
  end

  def equal?(new_pixel)
    if new_pixel.rgb=[@red,@green,@blue]
      return true
    else
      return false
    end

  end
  alias eql? equal?

  def to_s
    return  "Pixel with red=#{@red}, green=#{@green}, blue=#{@blue} and brightness=#{ @brightness.round(3)}"+"\n"
  end
  alias old_to_s to_s
  def inspect
    old_to_s
  end
  def red
    @red
  end
  def green
    @green
  end
  def blue
    @blue
  end
  def brightness
    @brightness
  end
  alias r red
  alias g green
  alias b blue
  alias br brightness

end