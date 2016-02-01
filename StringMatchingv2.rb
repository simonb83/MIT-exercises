#iterative function for finding number of times key apears in target string

def countSubStringMatch(target,key)

allMatches = target.scan(/#{key}/)

numberMatches = allMatches.size

puts "key is #{key}\ntarget is #{target}\nkey string appears #{numberMatches} times" 

end


countSubStringMatch("atgacatgcacaagtatgcat","a")
countSubStringMatch("atgacatgcacaagtatgcat","atg")
countSubStringMatch("atgacatgcacaagtatgcat","atgc")
countSubStringMatch("atgacatgcacaagtatgcat","atgca")
countSubStringMatch("atgaatgcatggatgtaaatgcag","a")
countSubStringMatch("atgaatgcatggatgtaaatgcag","atg")
countSubStringMatch("atgaatgcatggatgtaaatgcag","atgc")
countSubStringMatch("atgaatgcatggatgtaaatgcag","atgca")