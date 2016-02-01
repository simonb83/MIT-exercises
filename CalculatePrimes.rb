Primes = [2]
n = 3;

begin
    Length = Primes.length-1
    if Primes[1..Length].select{|x| n % x === 0}.empty?
        Primes << n
    end
    
    n += 1
    
end until Length === 99

puts Primes[999]