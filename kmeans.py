import numpy as np
import scipy
from scipy import cluster
import csv

ls = []
with open('/Users/esthenabarlow/Desktop/frlun.csv', 'rU') as file:
	rdr = csv.reader(file, delimiter = ',')
	for row in rdr:
		ls.append(float(row[0]))
	
test = np.array(ls)
result = scipy.cluster.vq.kmeans2(test, 400)

centroids = result[0]
labels = result[1]

for l in labels:
	print l