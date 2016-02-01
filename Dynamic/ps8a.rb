

def dpAdvisorCore(subjects,i,maxWork,m)
  
begin
  return m[[i,maxWork]]
rescue
  if i == 0
    if subjects[i][1].to_i <= maxWork
      m[[i,maxWork]] = subjects[i][0]
      return subjects[i][0]
    else
      m[[i,maxWork]] = 0
      return 0
    end
  end
  without_i = dpAdvisorCore(subjects,i-1,maxWork,m)
  if subjects[i][1].to_i > maxWork
    m[[i,maxWork]] = without_i
    return without_i
  else
    with_i = subjects[i][0].to_i + dpAdvisorCore(subjects,i-1,maxWork-subjects[i][1].to_i,m)
  end
  res = max(with_i,without_i)
  m[[i,maxWork]] = res
  puts "res is #{res}"
  return res
end

end

def dpAdvisor(subjects, maxWork)
# Returns a dictionary mapping subject name to (value, work) that contains a set of subjects that provides the maximum value without exceeding maxWork.
# subjects: dictionary mapping subject name to (value, work)
# maxWork: int >= 0
# returns: dictionary mapping subject name to (value, work)

i = subjects.length
m = Hash.new

return dpAdvisorCore(subjects,i,maxWork,m)

end