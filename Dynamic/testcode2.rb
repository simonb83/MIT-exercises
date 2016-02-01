a = {"6.00" => [16,8], "1.00" => [7,7], "6.01" => [5,3], "15.01" => [9,6]}
d = a.dup
b = {}
total_work = 0

while total_work <= 20 do
courses = d.keys
puts "calling main loop with remaining #{courses}"
puts "d is #{d}"
puts "b is #{b}"
for course in courses
    if d.select{|k,v| v[0]>d[course][0]}.empty? and b.values.inject(0){|sum,x| sum+x[1]} + d[course][1] <= 20
            b[course] = d[course]
            d.delete(course)
    end
end
total_work = b.values.inject(0){|sum,x| sum+x[1]}
end

puts b
puts d
puts x