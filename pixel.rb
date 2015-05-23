class Pixel

  def initialize(red,green,blue)
    if (red.is_a?Fixnum)&& (green.is_a?Fixnum) &&(blue.is_a?Fixnum)

      @red, @green, @blue=red, green, blue
    else
      raise Error, 'Wrong type for Pixel'
    end
    if (red>255)|(red<0)|(green>255)|(green<0)|(blue>255)|(blue<0)
      raise Error,  "Color Out of Bound, #{red},#{green}, #{blue}"
    end
    brtn
  end

  def brtn
    @brightness=0.2126 * @red + 0.7152 * @green + 0.0722 * @blue
  end
  def rgb
    [@red,@green,@blue]
  end

  def equal?(new_pixel)
    new_pixel.rgb=[@red, @green, @blue] ?  true :  false

  end
  alias eql? equal?

  def to_s
    "Pixel with red=#{@red}, green=#{@green}, blue=#{@blue} and brightness=#{ @brightness.round(3)}"+"\n"
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

  def red=(r)
    @red=r
    brtn
  end
  def green=(g)
    @green=g
    brtn
  end
  def blue=(b)
    @blue=b
    brtn
  end
  def rgb=(*args)
    @red, @green, @blue=args[0],args[1],args[2] if args.length==3
    if args.length==1 &&(args[0].is_a?Array)
      @red,@green,@blue=args[0][0],args[0][1],args[0][2]
    end
    brtn
  end
  alias  r= red=
  alias g= green=
  alias b= blue=
end