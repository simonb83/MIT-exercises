#Declare and initialize array to store Primes
Primes = [2, 3]
#Declare and initialize variable for calculation
n = 4;

#Asks for user input to determine endpoint 
puts "Which prime would you like?"
p = Integer(gets)
Finish = p-1

#Loop for iterating through n until endpoint is reached
begin
    #Calculate square root of n
    sqRoot = Integer(Math.sqrt(n))
    
    #Find index of element in Primes closest to square root of n
    y = (0...Primes.length).select{|x| Primes[x]<=sqRoot}.last
    
    #Calculate length of Primes array and subtract 1
    l = Primes.length-1
    
    #Loop statement to check if n can be divided by all primes up to square root
    if Primes[0..y].select{|x| n % x === 0}.empty?
        #if no, add n to the end of the array
        Primes << n
    end
    
    #Increase n by 1
    n += 1
    
    #End loop when endpoint is reached
end until l === Finish

#Print out answer
puts Primes[Finish]