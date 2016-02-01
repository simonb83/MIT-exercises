#Simple model of post retirement fund amounts based on variable growth rates and expenses
def postRetirement(savings, growthRates, expenses)

#define and initialize array to hold fund values  
fund = Array.new

#calculate value of fund after year 1
fund[0] = savings*(1 + 0.01*growthRates[0]) - expenses
  
#loop to calculate value of fund after year i based on year i-1
  for i in (1..growthRates.length-1)
    fund[i] = fund[i-1]*(1 + 0.01*growthRates[i]) - expenses
  end
  
puts "fund is #{fund}"

end

a = [10,5,0,5,1]

postRetirement(5266.26,a,1229.96)
