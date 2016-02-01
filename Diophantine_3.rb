#Declare function to check is there is a solution for a given N
def  has_solution(n)
# Store input in variable N
$N = n

#Declare and initialize variables to find the maximum number of times 6, 9 and 20 divide into N
$A_6 = $N/6
$A_9 = $N/9
$A_20 = $N/20

#Declare and initialize arrays to store potential combinations, where A is number of 6 packs, B number of 9 packs and C number of 20 packs
@A = (0..$A_6).to_a
@B = (0..$A_9).to_a
@C = (0..$A_20).to_a

#Declare function to calculate different combinations of A, B and C
def test(i,j,k)
return @A[i]*6 + @B[j]*9 + @C[k]*20
end

#Loop to exhaustively test combinations of A, B and C, with values ranging between 1 and the maximum number of times 6, 9 and 20 divide into N
for i in (0..$A_6)
    for j in (0..$A_9)
        for k in (0..$A_20)
            #Use declared function test to check each combination of i,j and k, and if it is equal to N, print out values of i, j and k
            if test(i,j,k) == $N
               return true
            end
        end
    end
end

end

#Declare and initialize counting variable to track consecutive solutions
c = 0
#Declare and initialize variable for number of nuggets
$M = 1
#Declare and initialize variable to hold largest number that cannot be bought in exact quantity
$Largest_N = 1

#Loop through testing each M until the counting variable is at 6, representing 6 consecutive solutions
until c == 6 do
#Check whether there exists a solution for given value of M, using previously declared function
if has_solution($M) == true
    #If there is a solution, increase counting variable by 1
    c += 1
else
    #If there is no solution for the value of M, store this value in Largest_N, and return counting variable to 0
    $Largest_N = $M
    c = 0
end
#Increment M by 1
$M += 1
end

puts "Largest number of McNuggets that cannot be bought in exact quantity : #{$Largest_N}"
