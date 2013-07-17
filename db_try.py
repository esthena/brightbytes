import pandas as pd

clar_col_names = ["ID", "SchoolID", "Name", "Private School", "Address", "Town", "State", "Zip", "County", "Min_Grade", "Max_Grade", "Phone"] 
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

def search_list(attr, current_list, db_in, db_search):
	in_attrs = [str(x).replace(' ', "") for x in list(db_in[attr])]
	search_attrs = [str(y).replace(' ', "") for y in list(db_search[attr])]
	missing_attrs = []
	
	for ind in current_list:
		if ind<num_clarity_schools and ind<num_nces_schools:
			in_attr = in_attrs[ind]
			try:
				search_ind = search_attrs.index(in_attr)
				print str(list(db_in["ID"])[ind]) + ", " + str(list(db_in["Name"])[ind]) + ", " + str(list(db_search["ID"])[search_ind]) + ", " + str(list(db_search["Name"])[search_ind])
			except ValueError:
				missing_attrs.append(ind)
	return missing_attrs

#number of records in clarity that are missing from NCES
print "Name Matches"
missing_names = search_list("Name", clarity_indices, clarity, nces)
print "Phone Matches"
missing_phones = search_list("Phone", missing_names, clarity, nces)
print "Address Matches"
missing_addresses = search_list("Address", missing_phones, clarity, nces)
print "No Match"
for addr in missing_addresses:
	print list(clarity["Name"])[addr]
	
	
#number of records in NCES that are missing from Clarity
#missing_names = search_list("Name", nces_indices, nces, clarity)
#missing_phones = search_list("Phone", missing_names, nces, clarity)
#missing_addresses = search_list("Address", missing_phones, nces, clarity)
