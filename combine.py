import csv
import pandas as pd

#files = ['parents', 'teachers', 'elem', 'ms', 'hs']
files = ['hs']
for f in files:
	school_dict = {}
	file = f + '.csv'
	with open(file, 'rU') as csvfile:
		rdr = csv.reader(csvfile, delimiter = ',')
		col
		for row in rdr:
			row1 = [x.replace (",", "|") for x in row]
			key = (row1[0], row1[1], row1[2], row1[3])
			val = (row1[4], row1[5], row1[6], row1[7], row1[8])
			if key in school_dict and val:
				school_dict[key].append(val) 
			else:
				school_dict[key] = list(val)
	for key in school_dict:
		k = str(key); sch = str(school_dict[key])
		sch_str = sch.replace('(', "").replace(')', "")
	
		print (k[1:len(k)-1] + "," + sch_str[1:len(sch_str)-1])