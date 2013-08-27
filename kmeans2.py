import numpy as np
import scipy
from scipy import cluster
import csv

ls = []
math = []
with open('/Users/esthenabarlow/Desktop/wfrma.csv', 'rU') as file:
	rdr = csv.reader(file, delimiter = ',')
	for row in rdr:
		if len(row[0]) ==0 or len(row[1]) == 0 or len(row[2]) == 0:
			continue
		else:
			r0 = float(row[0])
			r1 = float(row[1])
			r2 = float(row[2])
			#ls.append((r0,r1,r2))	
			ls.append((r0,r1))
			math.append((r2))
	
test = np.array(ls)
result = scipy.cluster.vq.kmeans2(test, 9)

centroids = result[0]
labels = result[1]

for c in centroids:
	print c

i = 0
math_ach = {}
while i<len(labels):
	index = labels[i]
	if str(index) in math_ach:
		new = math_ach[str(index)]
		new.append(str(math[i]))
		math_ach[str(index)] = new
	else:
		math_ach[str(index)] = [str(math[i])]
	i+=1

print math_ach['0']
k = 0
while k<9:
	print len(math_ach[str(k)])
	k+=1