
require_relative 'vector'

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
    pairs.each do |pair|
      collide_pair(delta, pair.obj1, pair.obj2)
    end
    
  end

  def collide_pair(delta, obj1, obj2)
    fail
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

