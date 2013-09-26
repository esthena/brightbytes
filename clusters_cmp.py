import numpy as np
import scipy
from scipy import cluster
import csv

k_const = 5
while k_const < 6:
	print "\n"
	print k_const
	ids = []
	dems = []
	math = []

	with open('/Users/esthenabarlow/Desktop/wfrma.csv', 'rU') as file:
		rdr = csv.reader(file, delimiter = ',')
		next(rdr, None)
		for row in rdr:
			if len(row[0]) ==0 or len(row[1]) == 0 or len(row[2]) == 0:
				continue
			else:
				id = str(row[0])
				mt = float(row[1])
				skip = False
				for i in [1, 4,6,7,8,10,13,14,15,16,17,18]:
					if row[i] is None or len(row[i]) ==0:
						skip = True
				if skip:
					continue
				ppupilsp = float(row[4])
				ell_pct = float(row[6])
				spec_ed_pct = float(row[7])
				mhi = float(row[8])
				student_ct = float(row[10])
				white_pct = float(row[13])
				frlun_pct = float(row[14])
				yrs_ed = float(row[15])
				hisp_pct = float(row[16])
				blk_pct = float(row[17])
				asn_pct = float(row[18])
				
				if True:	
					ids.append(id)
					math.append(mt)
					dems.append((ppupilsp, ell_pct, spec_ed_pct, mhi, student_ct, white_pct, frlun_pct, yrs_ed, hisp_pct, blk_pct, asn_pct))
				
	dem_arr = np.array(dems)
	dem_centroids, dem_labels = scipy.cluster.vq.kmeans2(dem_arr, k_const, iter = 20)

	math_arr = np.array(math)
	math_centroids, math_labels = scipy.cluster.vq.kmeans2(math_arr, k_const, iter=20)
	
	indicator = 0
	while indicator < len(dems):
		print str(ids[indicator]) + "," + str(dem_labels[indicator]) + "," + str(math_labels[indicator])
		indicator += 1	


	
	k_const +=1