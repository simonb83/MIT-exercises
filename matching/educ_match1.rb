
#Read external text file and load subject names line by line
def getSubjects(filename, tierName)
  
#Define hash to hold subjects
hh = Hash.new

#Cycle through file and add each line as a value corresponding to the tierName in the array
File.open(filename).each do |line|
  (hh[tierName] ||= []) << line.chomp
end

#return the holding array
return hh

end

#Read candidate education and split into primary Tier depending on subject
def educationTier(student, tiers)

#Define array of uninteresting words
uninteresting = ["yo","lo","los","las","les","el","ella","y","e"]

#Take student education phrase and split it into words in array  
string = student['education']

#Define and initialize array to hold individual words from candidate education, removing the uninteresting ones
words = Array.new
string.split.each do |word|
  if uninteresting.include?(word) == false
    words << word
  end
end
puts words
#Array to hold different values of primary tier for each candidate
candidTier = Array.new

#Cycle through each word from education string, and each key in tiers hash
words.each do |word|  
  tiers.keys.each do |key|
    #If word matches to values associated with that tier key, then add tier key to candidTier array
    if tiers[key].include?(word)      
      candidTier << key      
    end    
  end
end

puts candidTier
  
end

#Define and initialize hashes for holding primary tier subjects
tierA, tierB, primaryTiers = Hash.new

#Load tier A subjects into tierA hash, and tier B subjects into tierB hash
tierA = getSubjects('tier-A.txt','TierA')
tierB = getSubjects('tier-B.txt','TierB')

#Merge tierA and tierB hashes to create the primaryTiers hash which contains the primary split of subjects
primaryTiers = tierA.merge(tierB)
#puts primaryTiers

student = {"education" => "yo estudie las matematicas y las artes"}

educationTier(student, primaryTiers)

