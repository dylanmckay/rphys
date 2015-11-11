
class BroadphaseResult
  attr_reader :obj1, :obj2, :definitely_touching

  def initialize(obj1, obj2, definitely_touching=false)
    fail if obj1 == obj2

    @obj1 = obj1
    @obj2 = obj2
    @definitely_touching = definitely_touching
  end
end

class NaiveBroadphase
  
  def find_possibly_colliding_pairs(world)
    # TODO: make prettier using iterators

    result = []
    world.objects.each do |obj1|
      world.objects.each do |obj2|
        if obj1 != obj2
          result << BroadphaseResult.new(obj1, obj2, false)
        end
      end
    end

    result
  end
end
