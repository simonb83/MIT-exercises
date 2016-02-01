#Simple model of retirement fund based on variable growth rates
def nestEggVariable (salary, save, growthRates)

#define and initialize array to hold fund values  
fund = Array.new

#calculate value of fund after year 1
fund[0] = salary*save*0.01
  
#loop to calculate value of fund after year i based on year i-1
  for i in (1..growthRates.length-1)
    fund[i] = fund[i-1]*(1 + 0.01*growthRates[i]) + salary*save*0.01
  end
  
puts "fund is #{fund}"

end

a = [3,4,5,0,3]

nestEggVariable(10000,10,a)
