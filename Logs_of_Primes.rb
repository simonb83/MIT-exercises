#Declare and initialize array to store Primes
Primes = [2, 3]
#Declare and initialize variable for calculation
n = 4;
$Length = 0;

#Asks for user input to determine endpoint 
puts "What is N?"
$N = Integer(gets)

#Loop which iterates through n until the last element of the Primes array is greater than user input N
while Primes[$Length] <= $N do
    #Calculate square root of n
    _SqRoot = Integer(Math.sqrt(n))
    
    #Find index of element in Primes closest to square root of n
    _closeIndex = (0...Primes.length).select{|x| Primes[x]<=_SqRoot}.last
    
    #Calculate length of Primes array and subtract 1
    $Length = Primes.length-1
    
    #Loop statement to check if n can be divided by all primes up to square root
    if Primes[0.._closeIndex].select{|x| n % x === 0}.empty?
        #if no, add n to the end of the array
        Primes << n
    end
    
    #Increase n by 1
    n += 1
    
    #End loop when endpoint is reached
end

#puts Primes

$SumOfLogs = 0

for i in (0...$Length)
  #puts "Sum of Logs is #{SumOfLogs}"
  $SumOfLogs += Math.log(Primes[i])
end

ratio = $SumOfLogs/$N

#Print out answer
puts "Sum of Logarithms is #{$SumOfLogs}"
puts "N is #{$N}"
puts "Ratio of Sum of Logarithms to N is #{ratio}"