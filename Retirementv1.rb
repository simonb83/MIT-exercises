#Simple model of retirement fund based on fixed growth rate
def nestEggFixed (salary, save, growthRate, years)

#define and initialize array to hold fund values  
fund = Array.new

#calculate value of fund after year 1
fund[0] = salary*save*0.01
  
#loop to calculate value of fund after year i based on year i-1
  for i in (1..years-1)
    fund[i] = fund[i-1]*(1 + 0.01*growthRate) + salary*save*0.01
  end
  
puts "fund is #{fund}"

end

nestEggFixed(10000,10,15,5)
