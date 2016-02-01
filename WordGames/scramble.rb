def scramble(word)
    
#Sub method to return all possible permutations of a given string
def all_possible_permutations
    self.chars.to_a.permutation.map(&:join)
end

#Define and initialize array to hold possible permutations
subWords = Array.new

#Loop through each character of the word
for i in (0..word.length-1)
#For each i, fix that character
fix = word[i..i]
#Calculate the string which is formed by removing the fixed character from the word
if i-1 < 0
    scr = word[i+1..word.length-1]
else
    scr = word[0..i-1]+word[i+1..word.length-1]
end
#Add the fixed character to the array
subWords << fix
#Add the sub string formed by removing the fixed character
subWords << scr
#Calculate the array of all possible permutations of the sub string
permuted = scr.all_possible_permutations
#Loop through the array of permutations, and add the permutations to the fixed character
for j in (0..permuted.length-1)
    subWords << permuted[j]
    m = fix+permuted[j]
    subWords << m
end
end
#Reduce the array to unique values and sort by string length
sorted = subWords.uniq.sort_by {|x| x.length}
#Print out and return the sorted array
puts sorted
puts "total number of words is #{sorted.length}"
return sorted
end

word4 = "abcd"
scramble(word4)






string = "abcd"

$ans = Array.new
def subs(string)

length = string.length

puts "calling with #{string}, length is #{length}"

if length == 2
    str1 = string[0..0]
    str2 = string[1..1]
    $ans.concat([str1, str2, str1+str2])
else
    first = string[0..0]
    rest = string[1..length-1]
    puts "first is #{first}, rest is #{rest}"
    $ans << first
    new1 = subs(rest)
    $ans.concat(new1)
    new2 = new1.each{|i| first+i}
    $ans.concat(new2)
end

end

t = subs(string).uniq