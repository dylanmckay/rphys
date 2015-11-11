
require_relative 'vector'

class RigidBody
  attr_reader :shape, :transform, :mass, :velocity
  attr_writer :transform, :mass, :velocity

  def initialize(shape,
                 mass = 1,
                 transform = Transform.new)
    @shape = shape
    @transform = transform
    @velocity = Vector.new(0,0,0)
    @mass = mass
  end

  def intersects(body)
    # TODO: implement
    false

    # for sphere
    #distance = (@center - sphere.center).length
    #distance <= @radius + @sphere.radius
  end
end

