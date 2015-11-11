#! /usr/bin/ruby

require './broadphase'

SIMULATION_STEP = 0.1
SIMULATION_TIME = 1


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

# A 4x4 transformation matrix in row-major order.
class Transform
#  attr_writer :cels

  # Creates the identity matrix
  def initialize
    @cells = [
      1, 0, 0, 0,
      0, 1, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1
    ]
  end

  def position!(pos)
    @cells[@cells.index(12)] = pos.x
    @cells[13] = pos.y
    @cells[14] = pos.z
  end

  def translate!(amount)
    @cells[12] += amount.x
    @cells[13] += amount.y
    @cells[14] += amount.z
  end

  def translation
    Vector.new(@cells[12],
               @cells[13],
               @cells[14])
  end

  def scale!(factor)
    @cells[0] *= factor.x
    @cells[5] *= factor.y
    @cells[10] *= factor.z
  end
end


class Sphere
  def initialize(radius)
    @radius = radius
  end
end

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

class World
  attr_reader :objects

  def initialize(broadphase,
                gravity=Vector.new(0,-9.81,0))
    @objects = []
    @broadphase = broadphase
    @gravity = gravity
  end

  def step(delta)
    pairs = find_colliding_pairs
    handle_collision(delta, pairs)

    apply_gravity(delta)
    integrate(delta)
  end

  def add_object(obj)
    @objects << obj
    obj
  end

  private

  def handle_collision(delta, pairs)
    
  end

  # finds the pairs of objects that definitely are colliding
  def find_colliding_pairs
    @broadphase.find_possibly_colliding_pairs(self).select do |pair|
      pair.obj1.intersects(pair.obj2)
    end
  end

  def apply_gravity(delta)
    dv = @gravity*delta

    @objects.each do |obj|
      obj.velocity += dv
    end
  end

  def integrate(delta)
    @objects.each do |obj|
      dr = obj.velocity * delta
      obj.transform.translate!(dr)
    end
  end
end

broadphase = NaiveBroadphase.new

world = World.new(broadphase)

unit_sphere = Sphere.new(1)
obj1 = world.add_object(RigidBody.new(unit_sphere))
obj2 = world.add_object(RigidBody.new(unit_sphere))

# TODO: refactor
time = 0
while time <= SIMULATION_TIME

  world.step(SIMULATION_STEP)
  time += SIMULATION_STEP

  puts "#{obj1.transform.translation}"
end
