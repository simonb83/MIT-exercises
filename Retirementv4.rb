
def findMaxExpenses(salary, save, preRetireGrowthRates, postRetireGrowthRates, epsilon)
  
preRetireSavings = Array.new

preRetireSavings[0] = salary*save*0.01

#loop to calculate value of fund after year i based on year i-1
  for i in (1..preRetireGrowthRates.length-1)
    preRetireSavings[i] = preRetireSavings[i-1]*(1 + 0.01*preRetireGrowthRates[i]) + salary*save*0.01
  end
  
finalSavings = preRetireSavings[preRetireGrowthRates.length-1]

puts "finalSavings is #{finalSavings}"

postRetireSavings = Array.new
upper = finalSavings
lower = 0

begin
  
  expenses = (lower + upper)/2
  
  postRetireSavings[0] = finalSavings*(1 + 0.01*postRetireGrowthRates[0]) - expenses
  
  for i in (1..postRetireGrowthRates.length-1)
    postRetireSavings[i] = postRetireSavings[i-1]*(1 + 0.01*postRetireGrowthRates[i]) - expenses
  end
  
amountRemaining = postRetireSavings[postRetireGrowthRates.length-1]
  
  if amountRemaining > epsilon
    lower = expenses + 1
  else
    upper = expenses - 1
  end
  
puts "lower is #{lower}, upper is #{upper}" 

end until epsilon - amountRemaining.abs > 0
puts "Expenses should be #{expenses}"
end

a = [3,4,5,0,3]
b = [10,5,0,5,1]

findMaxExpenses(10000,10,a,b,0.01)