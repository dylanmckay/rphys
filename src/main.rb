#! /usr/bin/ruby

require_relative 'broadphase'
require_relative 'vector'
require_relative 'transform'
require_relative 'shapes'
require_relative 'rigidbody'
require_relative 'world'

SIMULATION_STEP = 0.1
SIMULATION_TIME = 1


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
