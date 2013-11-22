import numpy as np
import scipy as sp
from scipy import cluster
import csv

k_const = 8
global_min_cluster = 0
while global_min_cluster < 44:
	print "\n"
	print k_const
	ids = []
	ls = []
	math = []
	locs = []
	vars = []
	#mac air: with open ('/Users/esthenabarlow/Dropbox/EBDesktop/clusters_blanks/elem/elem_input.csv', 'rU') as file:
	with open ('/Users/Esthena/Desktop/kmeans_input.csv', 'rU') as file:
		rdr = csv.reader(file, delimiter = ',')
		next(rdr, None)

		for row in rdr:
			if len(row[0]) ==0:
				continue
			else:
				skip = False
				for i in [0,1,2,3,4,5,6,7,8,9,10,11]:
					if row[i] is None or len(row[i]) ==0:
						skip = True
				if skip:
					continue
				id = float(row[0])
				nces_id = float(row[1])
				student_count = float(row[7])
				st_rat = float(row[8])
				frlun_pct = float(row[9])
				eth_pct = float(row[10])
				pps = float(row[11])
				row_vals = (student_count, st_rat, frlun_pct, eth_pct, pps)
				vars.append(row_vals)
				mt = 0
				if True:
					ids.append(id)
					math.append(mt)
					ls.append(row_vals)

	# mac air: f = open('/Users/esthenabarlow/Dropbox/EBDesktop/clusters_blanks/elem/size12.csv', 'wb')
	f = open('/Users/Esthena/Desktop/kmeans_output.csv', 'wb')

	test = np.array(ls)
	result = sp.cluster.vq.kmeans2(test, k_const, iter = 10)

	centroids = result[0]
	labels = result[1]

	i = 0
	math_ach = {}
	while i<len(labels):
		index = labels[i]
		if str(index) in math_ach:
			new = math_ach[str(index)]
			new.append(math[i])
			math_ach[str(index)] = new
		else:
			math_ach[str(index)] = [math[i]]
		i+=1
	
	k = 0
	mx_std_dev = 0
	mn_std_dev = 100
	mx_avg = 0
	mn_avg = 100
	mn_cluster = 40000
	
	
	for c in centroids:
		f.write(str(c))
	f.write("\n")
	f.write("\n")
	
	j=0
	f.write("id, cluster,student_count, st_rat, frlun_pct, eth_pct, pps\n")
	while j<len(labels):
		f.write(str(ids[j]) + ", " + str(labels[j]) + "," + str(vars[j]) + "\n")
		j+=1
	f.write("\n")
	
	while k < k_const:
		if str(k) in math_ach:
			cluster_size = len(math_ach[str(k)])
			mean = np.mean(math_ach[str(k)])
			std_dev = np.std(math_ach[str(k)])
			f.write(str(k) + ", " + str(cluster_size) + ", " + str(mean) + ", " + str(std_dev) + "\n")
			if mean<mn_avg:
				mn_avg = mean
			if mean>mx_avg:
				mx_avg = mean
			if std_dev < mn_std_dev:
				mn_std_dev = std_dev
			if std_dev > mx_std_dev:
				mx_std_dev = std_dev
			if cluster_size < mn_cluster:
				mn_cluster = cluster_size
		k+=1
	
	global_min_cluster = mn_cluster
	print "mean min: " + str(mn_avg)
	print "mean max: " + str(mx_avg)
	print "min stdev: " + str(mn_std_dev)
	print "max stdev: " + str(mx_std_dev)
	print "min cluster size: " + str(mn_cluster)
#	k_const +=1
