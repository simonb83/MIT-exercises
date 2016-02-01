# 6.00 Problem Set 9
#
# Name:
# Collaborators:
# Time:

#from string import *

class Shape

  def self.area
    #raise AttributeException("Subclasses should override this method.")
  end

end

class Square < Shape
  def initialize(h)
    @h = h
  end
  
  def side
    side = h.to_f
  end
  
  attr_reader :h
  
  def area
    return side**2
  end
  
  def to_str
    return "Square with side #{side}"
  end

  def ==(other_square)
  other_square.class == Square && self.side == other_square.side
  end
  
end

class Circle < Shape
  def initialize(r)
    @r = r
  end
  
  def radius
    radius = r.to_f
  end
  
  attr_reader :r
  
  def area
    return 3.14159*(radius**2)
  end
  
  def to_str
    return "Circle with radius #{radius}"
  end

  def ==(other_circle)
  other_circle.class == Circle && self.radius == other_circle.radius
  end
  
end

class Triangle < Shape
  def initialize(b,h)
    @b = b
    @h = h
  end
  
  def base
    base = b.to_f
  end
  
  def height
    height = h.to_f
  end
  
  attr_reader :b, :h
  
  def area
    return 0.5*base*height
  end
  
  def to_str
    return "Triangle with base #{base} and height #{height}"
  end

  def ==(other_triangle)
  other_triangle.class == Triangle && self.base == other_triangle.base && self.height == other_triangle.height
  end
  
end

class Shapeset
  
  def initialize()
    @members = []
    @index = 0
  end
  
  attr_reader :members, :index
  
  def addShape(sh)
    if self.members.include?(sh) == false
      self.members << sh
    end
  end
  
  def each
    for i in self.members
      yield i
    end
  end
  
  def to_str
    myString = ""
    self.members.each do |shape|
      myString += shape.to_str + "\n"
    end
    return myString
  end

end

def findLargest(shapes)
  
dict = Hash.new

shapes.each do |shape|
  dict[shape.to_str] = shape.area
end

max_val = dict.max_by{|k,v| v}.last
largest = []

dict.each do |k,v|
  if v == max_val
    largest << [k,v]
  end
end

return largest
  
end

#ss = Shapeset.new
#ss.addShape(Triangle.new(1.2,2.5))
#ss.addShape(Circle.new(4))
#ss.addShape(Square.new(3.6))
#ss.addShape(Triangle.new(1.6,6.4))
#ss.addShape(Circle.new(2.2))

#ss = Shapeset.new
#ss.addShape(Triangle.new(3,8))
#ss.addShape(Circle.new(1))
#ss.addShape(Triangle.new(4,6))

#t = Triangle.new(6,6)
#c = Circle.new(1)
#ss = Shapeset.new
#ss.addShape(t)
#ss.addShape(c)
#


def readShapesFromFile(filename)

ss = Shapeset.new
inputFile = File.new(filename, "r")

for line in inputFile
  if line.split(/, */)[0].strip == 'circle'
    ss.addShape(Circle.new(line.split(/, */)[1].strip))
  elsif line.split(/, */)[0].strip == 'square'
    ss.addShape(Square.new(line.split(/, */)[1].strip))
  else
    ss.addShape(Triangle.new(line.split(/, */)[1].strip,line.split(/, */)[2].strip))
  end  
end

return ss

end

ss = readShapesFromFile('shapes.txt')

largest = findLargest(ss)
for i in (0..largest.length-1)
  puts "Largest element is #{largest[i][0]} with area #{largest[i][1]}"
end