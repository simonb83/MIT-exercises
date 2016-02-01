
#Read external text file and load subject names line by line
def getSubjects(filename)

string = String.new
  
#Cycle through file and concatenate all lines into a single string
File.open(filename).each do |line|
  string.concat(line.chomp)
end

#return the string
return string

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

candidTier = Hash.new

tiers.keys.each do |key|
  
  candidTier[key] = 0
  
  words.each do |word|
    
    if tiers[key].include?(word)
      candidTier[key] += 1
    end
    
  end
end

puts candidTier

end
  
  

#Load tier A subjects into tierA hash, and tier B subjects into tierB hash
tierA = getSubjects('tier-A.txt')
tierB = getSubjects('tier-B.txt')

primaryTiers = Hash.new
primaryTiers["TierA"] = tierA
primaryTiers["TierB"] = tierB

#puts primaryTiers

student = {"education" => "yo estudie las matematicas y las artes y la ingenieria"}

educationTier(student, primaryTiers)

