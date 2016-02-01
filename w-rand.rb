def wsb(weights)
  rnd = rand * weights.inject{|sum,x| sum+x}
  for i,w in weights.each_with_index{}
end
