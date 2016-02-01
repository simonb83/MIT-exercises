a = {"6.00" => [16,8], "1.00" => [7,7], "6.01" => [5,3], "15.01" => [9,6]}
d = a.dup
x = 0
b = {}
v
while x <= 20
courses = d.keys
for course in courses
    if d.select{|k,v| v[0]>d[course][0]}.empty?
        x = b.values.inject(0){|sum,x| sum+x[1]}
        if  x + d[course][1] <= 20
            b[course] = d[course]
            d.delete(course)
        end
    end
    courses = d.keys
end
end

puts b
puts d
puts x