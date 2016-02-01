A = [0,1,2,3,4]
A2 = [0]
B = [0,1,2,3,4]
B2 = [0]

for i in (0..A.length-1)
A2[i] = A[i]*9
#puts A2[i]
end

for i in (0..B.length-1)
B2[i] = B[i]*6
#puts B2[i]
end

C = Array.new(5) { Array.new(2) { 0 } }

#puts C

for i in (0..4)
C[i][0] = A2[i]
end
for i in (0..4)
C[i][1] = B2[i]
end
puts C

def h(i,j,k,l)
return C[i][j] + C[k][l];
end

for i in (0..4)
    for j in (0..1)
        for k in (0..4)
            for l in (0..1)
            if h(i,j,k,l) == 15
            puts "(#{C[i][j]}, #{C[k][l]})"
            end
            end
        end
    end
end
