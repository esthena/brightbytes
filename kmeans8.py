import numpy as np
import scipy
from scipy import cluster
import csv

k_const = 8
while k_const < 9:
	print "\n"
	print k_const
	ids = []
	ls = []
	math = []
	locs = []
	vars = []
#	with open('/Users/esthenabarlow/Desktop/clusters/nation/tiers/sensitivity_analysis/40000_sensitivity.csv', 'rU') as file:
#	with open('/Users/esthenabarlow/Desktop/clusters/40000_percentile.csv', 'rU') as file:
#	with open('/Users/esthenabarlow/Desktop/clusters/nation/tiers/sensitivity_analysis/graduation/g40000_sensitivity.csv', 'rU') as file:
#	with open('/Users/esthenabarlow/Desktop/clusters/high_schools/grad_input.csv', 'rU') as file:
	with open('/Users/esthenabarlow/Dropbox/EBDesktop/input/40000_percentile.csv', 'rU') as file:

		rdr = csv.reader(file, delimiter = ',')
		next(rdr, None)
	
		for row in rdr:
			skip = False
			for i in [0,1,2,3,4,5,6,7,8,9,10,11,12]:
				if row[i] is None or len(row[i]) ==0:
					skip = True
			if skip:
				continue
			id = str(row[0])
			mt = float(row[5])
			ppupilsp = float(row[12])
			ell_pct = float(row[10])
			spec_ed_pct = float(row[11])
			mhi = float(row[4])
			white_pct = float(row[9])
			frlun_pct = float(row[2])
			yrs_ed = float(row[3])
			hisp_pct = float(row[7])
			blk_pct = float(row[8])
			asn_pct = float(row[6])
			row_vals = (ppupilsp, ell_pct, spec_ed_pct, mhi, white_pct, yrs_ed, hisp_pct, blk_pct, asn_pct, frlun_pct)
			vars.append(row_vals)
			if True:
				ids.append(id)
				math.append(mt)
				ls.append(row_vals)

	f = open('/Users/esthenabarlow/Dropbox/EBDesktop/multi_dimensional/8.csv', 'wb')
	
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
	
	
	for c in centroids:
		f.write(str(c))
	f.write("\n")
	f.write("\n")
	
	j=0
	f.write("id, cluster,ppupilsp, ell_pct, spec_ed_pct, mhi, frlun_pct, yrs_ed\n")
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
	
	
	print "mean min: " + str(mn_avg)
	print "mean max: " + str(mx_avg)
	print "min stdev: " + str(mn_std_dev)
	print "max stdev: " + str(mx_std_dev)
	print "min cluster size: " + str(mn_cluster)
	k_const +=1
