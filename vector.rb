
class Vector
  attr_reader :x, :y, :z

  def initialize(x,y,z)
    @x = x
    @y = y
    @z = z
  end

  def as_positive
    Vector.new(abs(@x), abs(@y), abs(@z))
  end

  def length
    Math.sqrt(@x*@x + @y*@y + @z*@z)
  end

  def map(&fn)
    Vector.new(fn.call(@x),
               fn.call(@y),
               fn.call(@z))
  end

  def zip_map(other, &fn)
    Vector.new(fn.call(@x, other.x),
               fn.call(@y, other.y),
               fn.call(@z, other.z))
  end

  def *(rhs)
    if rhs.is_a?(Vector)
      zip_map(rhs) { |a,b| a*b }
    else
      map { |a| a*rhs }
    end
  end

  def +(rhs)
    if rhs.is_a?(Vector)
      zip_map(rhs) { |a,b| a+b }
    else
      map { |a| a+rhs }
    end
  end

  def -(rhs)
    if rhs.is_a?(Vector)
      zip_map(rhs) { |a,b| a-b }
    else
      map { |a| a-rhs }
    end
  end

  def to_s
    "(#{@x},#{@y},#{@z})"
  end
end


