puts "What is your name?:"
start_time = Time.new
name = gets
end_time = Time.new
total_time = end_time - start_time
puts "It took #{total_time} secs to enter your name"