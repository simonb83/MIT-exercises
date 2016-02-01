#Function to determine the starting points of key string in target string

def subStringMatchExact(target,key)
  
#Assign new variable to replace target during calculation  
newTarget = target
#Calculate number of characters in key
keySize = key.size
#Define and initialize variable to calculate starting index of where key appears in newTarget
index = 0
#Define and initialize start variable
start = 0
#Define and initialize variable for counting how much target string has been reduced
reduceCount = 0
#Define and initialize array for holding starting points
startingPoints = Array.new

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

puts "key is #{key}, target is #{target}, array of start values is #{startingPoints}"
  
end


subStringMatchExact("atgacatgcacaagtatgcat","a")
#subStringMatchExact("atgacatgcacaagtatgcat","at")
#subStringMatchExact("atgacatgcacaagtatgcat","atg")
#subStringMatchExact("atgacatgcacaagtatgcat","tgc")
#subStringMatchExact("atgacatgcacaagtatgcat","gc")
#subStringMatchExact("atgacatgcacaagtatgcat","c")
