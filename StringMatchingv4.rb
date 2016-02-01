#Function find elements for first array, n, such that n+m+1 = k, where k are elements of second array

def constrainedMatchPair(s1,s2,m)
  #Define and initialize array to hold relevant elements of n
  answ = Array.new
  #Loop through two arrays, testing each element
  for i in (0..s1.length-1)
    for j in (0..s2.length-1)
      #If condition holds true, add element to answer array
      if s1[i]+m+1 == s2[j]
        answ << s1[i]
      end
    end
  end
  
  puts "answer is #{answ}"
  return answ;

end

a = [0,3,5,9,11,12,15,19]
b = [7,17]

constrainedMatchPair(a,b,1)

