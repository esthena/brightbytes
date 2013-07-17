import pandas as pd
import csv

clar_col_names = ["ID", "SchoolID", "Name", "Type", "Address", "Town", "State", "Zip", "County", "Min_Grade", "Max_Grade", "Phone"] 
nces_col_names = ["ID", "Name", "Address", "Town", "State", "Zip", "Phone", "County", "Type", "Min_Grade", "Max_Grade"]

clarity = pd.read_csv("/Users/esthenabarlow/Desktop/matching.csv", header=None, names=clar_col_names, skiprows=1)
nces = pd.read_csv("/Users/esthenabarlow/Desktop/iowa_school_list.csv", header=None, names=nces_col_names, skiprows=1)

#creating list indicies as long as the respective school lists
num_clarity_schools = len(clarity)
num_nces_schools = len(nces)
clarity_indices =  list(xrange(num_clarity_schools))
nces_indices = list(xrange(num_nces_schools))

#this method searches for instances of the given attribute at the indexes in current list
# it returns a list of all of the indices that are in db_in but missing from db_search
#it also outputs a new csv file that will have clarity ids in it

def search_list(attributes, current_list, db_in, db_search):
	missing_indices = []
	for ind in current_list:
		if ind < num_clarity_schools and ind< num_nces_schools:	
			for attr in attributes:
				in_attrs = [str(x).replace(' ', "") for x in list(db_in[attr])]
				search_attrs = [str(y).replace(' ', "") for y in list(db_search[attr])]
				in_attr = in_attrs[ind]
				try:
					search_ind = search_attrs.index(in_attr)
					if attr == attributes[len(attributes)-1]:
						continue
#						print str(list(db_in["ID"])[ind]) + ", " + str(list(db_in["Name"])[ind]) + ", " + str(list(db_search["ID"])[search_ind]) + ", " + str(list(db_search["Name"])[search_ind])
					else:
						continue
				except ValueError:
					missing_indices.append(ind)
					break
	return missing_indices


#number of records in clarity that are missing from NCES
print "Name Matches"
missing_names = search_list(["Name"], clarity_indices, clarity, nces)
print "Phone Matches"
missing_phones = search_list(["Phone"], missing_names, clarity, nces)
print "Address Matches"
missing_addresses = search_list(["Zip", "Town", "Address"], missing_phones, clarity, nces)
file = open('non_match', 'w')
for addr in missing_addresses:
	file.write(list(clarity["Name"])[addr])
	print list(clarity["Name"])[addr] + " " + list(clarity["Address"])[addr]