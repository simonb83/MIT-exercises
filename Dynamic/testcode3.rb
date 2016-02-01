subjects = {"6.00" => [16,8], "1.00" => [7,7], "6.01" => [5,3], "15.01" => [9,6]}
options = subjects.dup
choices = Hash.new
total_work = 0
MAX_WORK = 15

def valueSort(options)
  
#Returns array sorted by course value

  return  options.sort_by{|k,v| -v[0]}[0]
  
end

def customSort(method, options)

  max = send(method,options)
  return max

end

while total_work <= MAX_WORK do

break if options.empty?

current_max = customSort(:valueSort,options)

if choices.values.inject(0){|sum,x| sum+x[1]} + current_max[1][1] <= MAX_WORK
    choices[current_max[0]] = options[current_max[0]]    
end

options.delete(current_max[0])
total_work = choices.values.inject(0){|sum,x| sum+x[1]}

end

puts "Best choices are #{choices}"
