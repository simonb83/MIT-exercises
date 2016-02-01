#Function find elements for first array, n, such that n+m+1 = k, where k are elements of second array

def subStringMatchExactlyOneSub(target,key)
  
#Break key into two sub-strings
key_r = key.reverse
suba1 = [""]
suba2 = [""]
  
for i in (0..key.length-2)
  suba1[i+1] = suba1[i] + key[i].chr
  suba2[i+1] = suba2[i] + key_r[i].chr
end
for i in (0..suba2.length-1)
suba2[i] = suba2[i].reverse
end

suba3 = suba2.reverse

#Define and initialize arrays for starting points for substring 1, and starting points for substring 2
starts1 = Array.new
starts2 = Array.new

for i in (0..suba1.length-1)
  starts1 << subStringMatchExact(target,suba1[i])
end

for i in (0..suba3.length-1)
  starts2 << subStringMatchExact(target,suba3[i])
end

#Define and initialize array to hold answer
answer = Array.new

for i in (0..starts1.length-1)
  m = suba1[i].length
  answer << constrainedMatchPair(starts1[i],starts2[i],m)
end

#Flatten array of arrays, extract unique answers and sort from smallest to largest
finalAnswer = answer.flatten.uniq.sort

#Check to ensure that matches meet the condition that exactly one element of the key is different
finalAnswer.reject! {|x| target[x..x+key.length-1] == key}

puts "answer is #{finalAnswer}"

end


#Function to determine the starting points of key string in target string

def subStringMatchExact(target,key)
  
#Assign new variable to replace target during calculation  
newTarget = target
#Calculate number of characters in key
keySize = key.size
#Define and initialize variable for counting how much target string has been reduced
reduceCount = 0
#Define and initialize variable to calculate starting index of where key appears in newTarget
index = 0
#Define and initialize start variable
start = 0
#Define and initialize array for holding starting points
startingPoints = Array.new

#If statement to check for empty key
if key == ""
  return
end

#Loop which ends when key no longer appears in sub strings of target
while index != nil do
  
  #Calculate size of newTarget string
  _targetSize = newTarget.size
  reduceCount = target.size - newTarget.size
  #Calculate index of first appearance of key in newTarget string
  index = newTarget =~ /#{key}/
  
  #If statement to exit when key no longer appears in newTarget
  if index == nil
    break
  end
  
  startingPoints << index + reduceCount
  
  #Calculate index in newTarget following first incidence of key
  start = index + keySize
  
  #Replace newTarget removing first instance of key and everything preceding
  newTarget = newTarget[start.._targetSize]
  
end

return startingPoints
  
end

def constrainedMatchPair(s1,s2,m)
  #Define and initialize array to hold relevant elements of n
  answ = Array.new
  #If statement to check for nil values for s1, or s2
  if s1 == nil
    for i in (0..s2.length-1)
      answ << s2[i]-1
    end
    return answ;
  end
  if s2 == nil
    for i in (0..s1.length-1)
      answ << s1[i]
    end
    return answ;
  end
  #Loop through two arrays, testing each element
  for i in (0..s1.length-1)
    for j in (0..s2.length-1)
      #If condition holds true, add element to answer array
      if s1[i]+m+1 == s2[j]
        answ << s1[i]
      end
    end
  end
  
  return answ;

end

subStringMatchExactlyOneSub("atgacatgcacaagtatgcat","agca")
