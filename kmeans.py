import numpy as np
import scipy
from scipy import cluster
import csv

ls = []
with open('/Users/Esthena/Desktop/kmaeans_input.csv', 'rU') as file:
	rdr = csv.reader(file, delimiter = ',')
	next(rdr,None)
	for row in rdr:
		if row[1] is not None and len(row[1]) != 0:
			ls.append(float(row[1]))
	
test = np.array(ls)
result = scipy.cluster.vq.kmeans2(test, 20)

centroids = result[0]
labels = result[1]

math_ach = {}
i=0
while i<len(labels):
	index = labels[i]
	if str(index) in math_ach:
		new = math_ach[str(index)]
		new.append(ls[i])
		math_ach[str(index)] = new
	else:
		math_ach[str(index)] = [ls[i]]
	i+=1

for key in math_ach:
	mn = np.mean(math_ach[key])
	stdv = np.std(math_ach[key])
	print mn
	print stdv
	