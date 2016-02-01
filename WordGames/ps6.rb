# Problem Set 5: 6.00 Word Game


$VOWELS = 'aeiou'
$CONSONANTS = 'bcdfghjklmnpqrstvwxyz'
$HAND_SIZE = 7

scrabble_letter_values = Hash.new

$scrabble_letter_values = {
    'a'=> 1, 'b'=> 3, 'c'=> 3, 'd'=> 2, 'e'=> 1, 'f'=> 4, 'g'=> 2, 'h'=> 4, 'i'=> 1, 'j'=> 8, 'k'=> 5, 'l'=> 1, 'm'=> 3, 'n'=> 1, 'o'=> 1, 'p'=> 3, 'q'=> 10, 'r'=> 1, 's'=> 1, 't'=> 1, 'u'=> 1, 'v'=> 4, 'w'=> 4, 'x'=> 8, 'y'=> 4, 'z'=> 10
}

WORDLIST_FILENAME = "words.txt"


def load_words()

#Returns a list of valid words. Words are strings of lowercase letters.
#Depending on the size of the word list, this function may
#take a while to finish.
    
print "Loading word list from file..."
file = File.new(WORDLIST_FILENAME, "r")
wordlist = Array.new
    
for line in file
    wordlist << line.strip.downcase
end

return wordlist
end

def get_words_to_points(word_list)
points_dict = Hash.new
    word_list.each do |word|
       points_dict[word] =  get_word_score(word, $HAND_SIZE)
    end
return points_dict
end

def get_frequency_dict(sequence)
    
#Returns a dictionary where the keys are elements of the sequence
#and the values are integer counts, for the number of times that
#an element is repeated in the sequence.

freq = Hash.new

if sequence.kind_of?(Array)

    sequence.each do |element|
        if freq[element]
            freq[element] += 1
        else
            freq[element] = 1
        end
    end

else
    sequence.each_char do |element|
        if freq[element]
            freq[element] += 1
        else
            freq[element] = 1
        end
    end
end

return freq

end

def get_word_rearrangements(word_list)
   
d = Hash.new

word_list.each do |word|
    d[word.split('').sort.join] = word
end

return d
end


def get_word_score(word, n)

#Returns the score for a word. Assumes the word is a valid word.

#The score for a word is the sum of the points for letters in the word, plus 50 points if all n letters are used on the first go.
#Letters are scored as in Scrabble; A is worth 1, B is worth 3, C is worth 3, D is worth 2, E is worth 1, and so on.
#word: string (lowercase letters)
#returns: int >= 0

#Add up score of individual characters in word

score = 0

word.each_char do |letter|
    score += $scrabble_letter_values[letter]
end

if word.length == n
    score += 50
end

return score

end

def display_hand(hand)
    
#Displays the letters currently in the hand.

#For example:
#display_hand({'a':1, 'x':2, 'l':3, 'e':1})
#Should print out something like: a x x l l l e
#The order of the letters is unimportant.
#hand: dictionary (string -> int)

hand.each_key do |key|
    v = hand[key].to_i
    v.times do
        print "#{key} "
    end
end
print "\n"

end

def deal_hand(n)
    
#Returns a random hand containing n lowercase letters.
#At least n/3 the letters in the hand should be VOWELS.

#Hands are represented as dictionaries. The keys are
#letters and the values are the number of times the
#particular letter is repeated in that hand.

#n: int >= 0
#returns: dictionary (string -> int)

hand = Hash.new
num_vowels = Integer(n / 3)
m = n - num_vowels
    
for i in (0..num_vowels-1)
    x = $VOWELS.split("").sort_by{rand}.join.slice(0)
    if hand[x]
        hand[x] += 1
    else
        hand[x] = 1
    end
end

for i in (num_vowels..n-1)
    x = $CONSONANTS.split("").sort_by{rand}.join.slice(0)
    if hand[x]
        hand[x] += 1
    else
        hand[x] = 1
    end
end

return hand

end


def update_hand(hand, word)

#Assumes that 'hand' has all the letters in word.
#In other words, assumes that however many times a letter appears in 'word', 'hand' has at least as many instances of that letter in it.
#Updates the hand: uses up the letters in the given word and returns the new hand, without those letters in it.
#Has no side effects: does not modify hand.
#word: string
#hand: dictionary (string -> int)
#returns: dictionary

#puts "original hand is..."
#display_hand(hand)

newHand = hand.dup

word.each_char do |letter|
    newHand[letter] = newHand[letter].to_i - 1
    if newHand[letter] == 0
        newHand.delete(letter)
    end
end

return newHand

end


def is_valid_word(word, hand, points_dict)

#Returns True if word is in the word_list and is entirely composed of letters in the hand. Otherwise, returns False.
#Does not mutate hand or word_list.
#word: string
#hand: dictionary (string -> int)
#word_list: list of strings

newHand = hand.dup

if points_dict.include?(word) == false
    return false
end

word.each_char do |letter|
    if newHand.has_key?(letter) == false || newHand[letter] == 0
        return false
    else
        newHand[letter] = newHand[letter].to_i - 1
    end    
end

return true

end

def build_substrings(string)

result = Array.new

if string.length == 1
    result << string
else
    for substring in build_substrings(string[0..-2])
        result << substring
        substring = substring + string[-1..-1]
        result << substring
    end
result << string[-1..-1]
end
sorted = result.sort_by{|value| value.length}.uniq
return sorted
end

def scramble(word,points_dict)

#Sub method to calculate all possible sub-strings of word, returns an array

#Sub method to return all possible permutations of a given string, returns an array
def all_possible_permutations
    self.chars.to_a.permutation.map(&:join)
end

#Define and initialize array to hold possible permutations
subStrings = Array.new
allWords = Array.new
validWords = Array.new

#Find all substrings of word and load to subStrings array
subStrings = build_substrings(word)

#For each substring, find all possible permutations and add to allWords array
for i in (0..subStrings.length-1)
    allWords.concat(subStrings[i].all_possible_permutations)
end

for j in (0..allWords.length-1)
    if points_dict.include?(allWords[j]) == true
        validWords << allWords[j]
    end
end

return validWords.uniq

end


def pick_best_word(hand, points_dict)
   
#Return the highest scoring word from points_dict that can be made with the given hand.
#Return '.' if no words can be made with the given hand.

#Create first string combining all letters in hand
first_string = ""
hand.each_pair do |key, value|
value.times do first_string << key; end
end
#puts "first string is #{first_string}"

#Create Array of all possible permutations
possibilities = Array.new
possibilities = scramble(first_string,points_dict)

print "list of possibilities is #{possibilities}\n"
print "total number of possibilities is #{possibilities.length}\n"

#Create hash of all possible word scores for given hand

possible_word_scores = Hash.new

for i in (0..possibilities.length-1)
    possible_word_scores[possibilities[i]] = get_word_score(possibilities[i],$HAND_SIZE)
    #puts "word score for #{all_permutations[i]} is #{possible_word_scores[all_permutations[i]]}"
end

if possible_word_scores.empty?
    return '.'
end

max_score = possible_word_scores.values.max
best_word = possible_word_scores.key(max_score)

#puts "best word score is #{best_word}"

return best_word

end

def pick_best_word_faster(hand, rearrange_dict)

possible_word_scores = Hash.new
   
#Create first string combining all letters in hand
first_string = ""
hand.each_pair do |key, value|
value.times do first_string << key; end
end

subStrings = Array.new
subStrings = build_substrings(first_string)

subStrings.each do |substring|
    w = substring.split('').sort.join
    if rearrange_dict.include?(w)
        possible_word_scores[rearrange_dict[w]] = get_word_score(rearrange_dict[w], $HAND_SIZE)    
    end
end

if possible_word_scores.empty?
    return '.'
end

max_score = possible_word_scores.values.max
best_word = possible_word_scores.key(max_score)

#puts "best word score is #{best_word}"

return best_word

end

def play_hand(hand, points_dict)

#Allows the user to play the given hand, as follows:
# * The hand is displayed.
# * The user may input a word. Alternatively, the user may end the game by entering a period (.).
# * An invalid word is rejected, and a message is displayed asking the user to choose another word.
# * When a valid word is entered, it uses up letters from the hand.
# * After every valid word: the score for that word and the total score so far are displayed, the remaining letters in the hand are displayed,
# and the user is asked to input another word.
# * The sum of the word scores is displayed when the hand finishes.
# * The hand finishes when there are no more unused letters.
# The user may choose to end the hand at any time by inputting a single period (the string '.') instead of a word.
# * The final score is displayed.
#hand: dictionary (string -> int)
#word_list: list of strings

wordScore = 0
totalScore = 0
updatedHand = Hash.new
updatedHand.replace(hand)
word = ""

puts "Enter time limit, in seconds, for players:"
max_time = gets.strip.to_f
time_remaining = max_time

display_hand(hand)

until updatedHand.empty?

if updatedHand.empty?
    puts "Hand is empty"
    break
end

puts "Enter a word or a . to indicate you are finished..."
start_time = Time.new
word = pick_best_word_faster(updatedHand, $rearrange_dict)
end_time = Time.new
break if word == "."
print "the best possible word was #{word}\n"

total_time = end_time - start_time
time_remaining = time_remaining - total_time
printf("It took %.2f seconds to provide an answer\n",total_time)
if time_remaining < 0
    printf("Total time exceeds %.2f seconds. You scored %.2f points\n", max_time, totalScore)
    return
end
wordScore = get_word_score(word,$HAND_SIZE) / total_time
totalScore += wordScore
updatedHand = update_hand(updatedHand,word)

printf("You have %.2f seconds remaining\n",time_remaining)
printf("word score for #{word} is %.2f points, total score is %.2f points\n", wordScore, totalScore)
print "updated hand is..."
display_hand(updatedHand)
if updatedHand.empty?
    puts "You have no letters left over"
    break
end
end

printf("Your final score is %.2f points\n", totalScore)

end


# Problem #5: Playing a game
# Make sure you understand how this code works!
# 
def play_game(word_list)

#Allow the user to play an arbitrary number of hands.

# * Asks the user to input 'n' or 'r' or 'e'.
# * If the user inputs 'n', let the user play a new (random) hand.
#   When done playing the hand, ask the 'n' or 'e' question again.
# * If the user inputs 'r', let the user play the last hand again.
# * If the user inputs 'e', exit the game.
# * If the user inputs anything else, ask them again.
points_dict = get_words_to_points(word_list)
hand = deal_hand($HAND_SIZE)
$rearrange_dict = get_word_rearrangements(word_list)

while true

puts "Enter n to deal a new hand, r to deplay the last hand, or e to end the game"
cmd = gets().strip

if cmd == 'n'
    hand = deal_hand($HAND_SIZE)
    play_hand(hand, points_dict)
elsif cmd == 'r'
    play_hand(hand, points_dict)
elsif cmd == 'e'
    break
else
    print "Invalid command" 
end

end

end

if __FILE__ == $0
    word_list = load_words()
    play_game(word_list)
end
