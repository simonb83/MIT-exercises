subjects = {"6.00" => [16,8], "1.00" => [7,7], "6.01" => [5,3], "15.01" => [9,6]}
options = subjects.dup
choices = Hash.new
total_work = 0
MAX_WORK = 15

def valueSort(options)
  
#Returns array sorted by course value

  return  options.sort_by{|k,v| -v[0]}[0]
  
end


def workSort(options)
  
#Returns array sorted by course work amount

  return  options.sort_by{|k,v| -v[1]}[0]
  
end

def ratioSort(options)
  
#Returns array sorted by course value

  return  options.sort_by{|k,v| -v[0]/v[1]}[0]
  
end

def customSort(method, options)

  max = send(method,options)
  return max

end

max1 = customSort(:valueSort,options)
puts "max1 is #{max1}"

#max2 = workSort(options)
#puts "max2 is #{max2}"

#max3 = ratioSort(options)
#puts "max3 is #{max3}"