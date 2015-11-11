

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



