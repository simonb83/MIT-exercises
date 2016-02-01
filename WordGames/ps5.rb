# Problem Set 5: 6.00 Word Game


$VOWELS = 'aeiou'
$CONSONANTS = 'bcdfghjklmnpqrstvwxyz'
$HAND_SIZE = 10

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

puts "#{wordlist.length} words loaded"
return wordlist
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

newHand = Hash.new
newHand.replace(hand)

word.each_char do |letter|
    newHand[letter] = newHand[letter].to_i - 1
end

return newHand

end


def is_valid_word(word, hand, word_list)

#Returns True if word is in the word_list and is entirely composed of letters in the hand. Otherwise, returns False.
#Does not mutate hand or word_list.
#word: string
#hand: dictionary (string -> int)
#word_list: list of strings

newHand = Hash.new
newHand.replace(hand)

if word_list.include?(word) == false
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


def play_hand(hand, word_list)

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

display_hand(hand)

until updatedHand.empty?

puts "Enter a word or a . to indicate you are finished..."
word = gets().strip.downcase

if word == "."
    break
end

until is_valid_word(word, hand, word_list) != false
    puts "you have not chosen a valid word, please try again"
    word = gets().strip.downcase
end

wordScore = get_word_score(word,$HAND_SIZE)
totalScore += wordScore
updatedHand = update_hand(updatedHand,word)

print "word score for #{word} is #{wordScore} points, total score is #{totalScore} points\n"
print "updated hand is..."
display_hand(updatedHand)
end

puts "your final score is #{totalScore} points"

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

hand = deal_hand($HAND_SIZE)

while true

puts "Enter n to deal a new hand, r to deplay the last hand, or e to end the game"
cmd = gets().strip

if cmd == 'n'
    hand = deal_hand($HAND_SIZE)
    play_hand(hand, word_list)
elsif cmd == 'r'
    play_hand(hand, word_list)
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

