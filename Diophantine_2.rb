#Ask for user input to get N
puts "What is N?"
# Store input in variable N
$N = Integer(gets)

#Declare and initialize variables to find the maximum number of times 6, 9 and 20 divide into N
$A_6 = $N/6
$A_9 = $N/9
$A_20 = $N/20

#Declare and initialize arrays to store potential combinations, where A is number of 6 packs, B number of 9 packs and C number of 20 packs
A = (0..$A_6).to_a
B = (0..$A_9).to_a
C = (0..$A_20).to_a

#Declare function to calculate different combinations of A, B and C
def test(i,j,k)
return A[i]*6 + B[j]*9 + C[k]*20
end

puts "#{$N} nuggets can be obtained by:"

#Loop to exhaustively test combinations of A, B and C, with values ranging between 1 and the maximum number of times 6, 9 and 20 divide into N
for i in (0..$A_6)
    for j in (0..$A_9)
        for k in (0..$A_20)
            #Use declared function test to check each combination of i,j and k, and if it is equal to N, print out values of i, j and k
            if test(i,j,k) == $N
                puts "No. of 6 packs = #{A[i]}, No. of 9 packs = #{B[j]}, No. of 20 packs = #{C[k]}"
            end
        end
    end
end