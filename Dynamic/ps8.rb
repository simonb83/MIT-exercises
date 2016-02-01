
def loadSubjects(filename)
  
#Loads subjects file and converts into hash with two values per key

inputFile = File.new(filename, "r")
subjects = Hash.new

#Cycle though file and convert data into hash
for line in inputFile

  subjects[line.split(/, */)[0].strip] = [line.split(/, */)[1].strip,line.split(/, */)[2].strip]

end

puts "#{subjects.length} subjects loaded"

return subjects

end

def printSubjects(subjects)
  
#Prints a string containing name, value, and work of each subject in the dictionary of subjects and total value and work of all subjects

totalVal = 0
totalWork = 0
if subjects.length == 0
    return 'Empty SubjectList'
end

res = "Course\tValue\tWork\n\t\t\n"

subNames = subjects.keys
subNames.sort

for s in subNames
    val = subjects[s][0]
    work = subjects[s][1]
    res = res + s.to_s + "\t" + val.to_s + "\t" + work.to_s + "\n"
    totalVal += val.to_i
    totalWork += work.to_i
end
res = res + "\nTotal Value:\t" + totalVal.to_s + "\n"
res = res + "Total Work:\t" + totalWork.to_s + "\n"
print res

end

def valueSort(options)
  
#Returns array sorted by course value
  
  return  options.sort_by{|k,v| -v[0].to_i}[0]
  
end


def workSort(options)
  
#Returns array sorted by course work amount

  return  options.sort_by{|k,v| -v[1].to_i}[0]
  
end

def ratioSort(options)
  
#Returns array sorted by ratio of course value to course work

  return  options.sort_by{|k,v| -v[0].to_i/v[1].to_i}[0]
  
end

def greedyAdvisor(comparator,subjects, maxWork)

#Returns a dictionary mapping subject name to (value, work) which includes subjects selected by the algorithm, such that the total work of subjects in
#the dictionary is not greater than maxWork.  The subjects are chosen using a greedy algorithm.  The subjects dictionary should not be mutated.

#subjects: dictionary mapping subject name to (value, work)
#maxWork: int >= 0
#comparator: function taking two tuples and returning a bool
#returns: dictionary mapping subject name to (value, work)

#Define and initialize options hash which is duplicate of subjects, choices hash which is used to store each best choice
options = subjects.dup
choices = Hash.new
#variable to store current amount of work
total_work = 0
$MAX_WORK = maxWork

#Loop until limit of max work is reached
while total_work <= $MAX_WORK do
#Break out of loop if all courses have been exhausted
break if options.empty?

#Calculate the next 'best' course based on candidate preferences using the right sort function
current_max = send(comparator,options)
#If including this 'best course' maintains amount of work within limit, then add to choices hash
if choices.values.inject(0){|sum,x| sum+x[1].to_i} + current_max[1][1].to_i <= $MAX_WORK
    choices[current_max[0]] = options[current_max[0]]    
end
#Delete current best course as this has either been included in choices hash, or would push total work over the limit
options.delete(current_max[0])
#Recalculate total work
total_work = choices.values.inject(0){|sum,x| sum+x[1].to_i}

end

return choices

end

def bruteForceAdvisor(subjects, maxWork)

#Returns a dictionary mapping subject name to (value, work), which represents the globally optimal selection of subjects using a brute force algorithm.

#subjects: dictionary mapping subject name to (value, work)
#maxWork: int >= 0
#returns: dictionary mapping subject name to (value, work)

    nameList = subjects.keys
    tupleList = subjects.values
    bestSubset, bestSubsetValue = bruteForceAdvisorHelper(tupleList, maxWork, 0, nil, nil, [], 0, 0)
    #puts "best Subset is #{bestSubset}, best value is #{bestSubsetValue}"
    outputSubjects = Hash.new
    for i in bestSubset
        outputSubjects[nameList[i]] = tupleList[i]
    end
    return outputSubjects
    
end

def bruteForceAdvisorHelper(subjects, maxWork, i, bestSubset, bestSubsetValue,
                            subset, subsetValue, subsetWork)
    # puts "calling helper with i = #{i}"
    # Hit the end of the list.
    if i >= subjects.length
        if bestSubset == nil or subsetValue > bestSubsetValue
            # Found a new best.
            return subset.dup, subsetValue
        else
            # Keep the current best.
            return bestSubset, bestSubsetValue
        end
    else
        s = subjects[i]
        # Try including subjects[i] in the current working subset.
        #puts "subject work is #{s[1]}"
        if subsetWork + s[1].to_i <= maxWork
            subset << i
            bestSubset, bestSubsetValue = bruteForceAdvisorHelper(subjects, maxWork, i+1, bestSubset, bestSubsetValue, subset,
                                                                  subsetValue + s[0].to_i, subsetWork + s[1].to_i)
            #puts "bestSubset1 is #{bestSubset}, bestSubsetValue is #{bestSubsetValue}"
            subset.pop  
        end
    end
    bestSubset, bestSubsetValue = bruteForceAdvisorHelper(subjects, maxWork, i+1, bestSubset, bestSubsetValue, subset, subsetValue, subsetWork)

return bestSubset, bestSubsetValue

end
    
    

def bruteForceTime(workValues, subjects)

#Runs tests on bruteForceAdvisor and measures the time required to compute an answer.

for value in workValues
start_time = Time.new
bestchoices = bruteForceAdvisor(subjects, value)
end_time = Time.new
total_time = end_time - start_time
printf("With Brute Force time taken for total work of #{value} is %.2f seconds\n",total_time)
end

end

def dpAdvisorCore(sub,i,maxWork,m)
  
#puts "calling with #{i}, #{maxWork}"
  
if m.has_key?([i,maxWork])
  return m[[i,maxWork]]

else
    if i == 0
      if sub[i][2].to_i <= maxWork
        m[[i,maxWork]] = sub[i][1].to_i,[i]
        return sub[i][1].to_i,[i]
      else
        m[[i,maxWork]] = 0,[]
        return 0,[]
      end
    end
    
    without_i, course_list = dpAdvisorCore(sub,i-1,maxWork,m)
    if sub[i][2].to_i > maxWork
      m[[i,maxWork]] = without_i, course_list
      return without_i, course_list
    else
      with_i, course_list_temp = dpAdvisorCore(sub,i-1,maxWork-sub[i][2].to_i,m)
      with_i += sub[i][1].to_i
    end
    if with_i > without_i
      i_value = with_i
      course_list = [i] + course_list_temp
    else
      i_value = without_i
    end
    m[[i,maxWork]] = i_value, course_list
    return i_value, course_list

end

end

def dpAdvisor(subjects, maxWork)
# Returns a dictionary mapping subject name to (value, work) that contains a set of subjects that provides the maximum value without exceeding maxWork.
# subjects: dictionary mapping subject name to (value, work)
# maxWork: int >= 0
# returns: dictionary mapping subject name to (value, work)

i = subjects.length-1
sub = Array.new
ans = Hash.new
m = Hash.new

subjects.each do |key,value|
  t = []
  t << key
  t << value[0]
  t << value[1]
  sub << t
end

value, rec_list = dpAdvisorCore(sub,i,maxWork,m)

rec_list.each do |int|
  
  ans[sub[int][0]] = sub[int][1], sub[int][2]

end

return ans

end

def dpTime(workValues, subjects)

#Runs tests on bruteForceAdvisor and measures the time required to compute an answer.

for value in workValues
start_time = Time.new
bestchoices = dpAdvisor(subjects, value)
end_time = Time.new
total_time = end_time - start_time
printf("With Dynamic Programming time taken for total work of #{value} is %.2f seconds\n",total_time)
end

end



#subjects = {"6.00" => [16,8], "1.00" => [7,7], "6.01" => [5,3], "15.01" => [9,6]}
#printSubjects(subjects)
#bestchoices = greedyAdvisor(:ratioSort, subjects, 60)
#printSubjects(bestchoices)

subjects = loadSubjects('subjects.txt')
workValues = [5,10,11]
bruteForceTime(workValues,subjects)
dpTime(workValues,subjects)

#bestchoices = dpAdvisor(subjects,30)
#printSubjects(bestchoices)

