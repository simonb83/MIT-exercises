#Recursive function for finding number of times key apears in target string

def countSubStringMatchRecursive(target,key)
#Assign new variable to replace target during calculation  
newTarget = target
#Calculate number of characters in key
keySize = key.size
#Define and initialize count variable for adding the number of times key appears in target
count = 0
#Define and initialize variable to calculate starting index of where key appears in newTarget
index = 0

#Loop which ends when key no longer appears in sub strings of target
while index != nil do
  
  #Calculate size of newTarget string
  _targetSize = newTarget.size
  #Calculate index of first appearance of key in newTarget string
  index = newTarget =~ /#{key}/
  
  #If statement to exit when key no longer appears in newTarget
  if index == nil
    break
  end
  
  #Calculate index in newTarget following first incidence of key
  start = index + keySize
  
  #Replace newTarget removing first instance of key and everything preceding
  newTarget = newTarget[start.._targetSize]
  
  #Increase count variable by 1 for each instance of key
  count += 1
  
end

puts "key is #{key}\ntarget is #{target}\nkey string appears #{count} times" 

end


countSubStringMatchRecursive("atgacatgcacaagtatgcat","a")
countSubStringMatchRecursive("atgacatgcacaagtatgcat","atg")
countSubStringMatchRecursive("atgacatgcacaagtatgcat","atgc")
countSubStringMatchRecursive("atgacatgcacaagtatgcat","atgca")
countSubStringMatchRecursive("atgaatgcatggatgtaaatgcag","a")
countSubStringMatchRecursive("atgaatgcatggatgtaaatgcag","atg")
countSubStringMatchRecursive("atgaatgcatggatgtaaatgcag","atgc")
countSubStringMatchRecursive("atgaatgcatggatgtaaatgcag","atgca")