import numpy as np
import scipy
from scipy import cluster
import csv

k_const = 29
while k_const < 30:
	print "\n"
	print k_const
	ids = []
	ls = []
	math = []
	locs = []

	with open('/Users/esthenabarlow/Desktop/kmeans clarity.csv', 'rU') as file:
		rdr = csv.reader(file, delimiter = ',')
		next(rdr, None)
		for row in rdr:
			if len(row[0]) ==0 or len(row[1]) == 0 or len(row[2]) == 0:
				continue
			else:
				id = str(row[0])
				mt = int(row[17])
				locale = row[15]
				locale.strip()
				skip = False
				for i in [1,8,6,7,12,14,13,10,9,11,15]:
					if row[i] is None or len(row[i]) ==0:
						skip = True
				if skip:
					continue
				ppupilsp = float(row[8])
				ell_pct = float(row[6])
				spec_ed_pct = float(row[7])
				white_pct = float(row[12])
				frlun_pct = float(row[14])
				yrs_ed = float(row[13])
				hisp_pct = float(row[10])
				blk_pct = float(row[9])
				asn_pct = float(row[11])
				#if locale == 'Rural':
				if locale == 'Rural' or locale == 'City' or locale == 'Suburb' or locale == 'Town' and mt!=800:
					ids.append(id)
					math.append(mt)
					locs.append(locale)
					ls.append((ppupilsp, ell_pct, spec_ed_pct, white_pct, frlun_pct, yrs_ed, hisp_pct, blk_pct, asn_pct))
	test = np.array(ls)
	result = scipy.cluster.vq.kmeans2(test, k_const, iter = 20)

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
	max_cluster = 0
	
	f = open('/Users/esthenabarlow/Desktop/clarity_kmeans/env1' + str(k_const) + '.csv', 'wb')
	
	for c in centroids:
		f.write(str(c))
	f.write("\n")
	f.write("\n")
	
	j=0
	f.write("Percent White, Percent F/R Lunch, Cluster Number\n")
	while j<len(labels):
		f.write(str(ls[j]) + ", " + str(labels[j]) + "\n")
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
			if cluster_size>max_cluster:
				max_cluster = cluster_size
		k+=1
	
	
	print "mean min: " + str(mn_avg)
	print "mean max: " + str(mx_avg)
	print "min stdev: " + str(mn_std_dev)
	print "max stdev: " + str(mx_std_dev)
	print "min cluster size: " + str(mn_cluster)
	print "max cluster size: " + str(max_cluster)
	k_const +=1
