import pandas as pd
import csv
import copy

col_names = ["ID", "Name", "Address", "Town", "State", "Zip", "Phone", "County", "Type", "Min_Grade", "Max_Grade"]

orig_clarity = pd.read_csv("/Users/esthenabarlow/Desktop/school_test.csv", header=None, names=col_names, skiprows=1)
orig_nces = pd.read_csv("/Users/esthenabarlow/Desktop/school_test_search.csv", header=None, names=col_names, skiprows=1)

clarity = copy.deepcopy(orig_clarity); nces = copy.deepcopy(orig_nces)

def map_replace(entry):
	problem_chars = ["'", "(", ")", ",", ".", "-", " ", "/", "JuniorHighSchool", "SeniorHighSchool", "SeniorHigh", "MiddleSchool", "HighSchool", "ElementarySchool", "Elementary", "Middle", "High"]
	replacement_chars = ["", "", "", "", "", "", "", "", "MS", "HS", "HS", "MS", "HS", "EL", "EL", "MS", "HS"]
	return_str = str(entry)
	for i in list(xrange(len(problem_chars))):
		return_str = return_str.replace(problem_chars[i], replacement_chars[i])
	return_str = return_str.lower()
	return return_str

for db in clarity, nces:
	for attr in col_names:
		db[attr] = db[attr].map(map_replace)

#creating list indices as long as the respective school lists
num_clarity_schools = len(clarity)
num_nces_schools = len(nces)
clarity_indices =  list(xrange(num_clarity_schools))
nces_indices = list(xrange(num_nces_schools))

#this method searches for instances of the given attribute at the indexes in current list
# it returns a list of all of the indices that are in db_in but missing from db_search
#it also outputs a new csv file that will have clarity ids in it

#list = [0,1,2,3,4,5]
#k = list.pop(0)
#print list
def search_list(attributes, db_base, db_to_search, missing_indices, orig_base_db, orig_search_db):
	still_missing = 0
	




exit()
def search_list(attributes, db_base, db_to_search, to_search, orig_base_db, orig_search_db):
	still_missing = []
	for search_index in to_search:
		attr = attributes[0]
		school_attr = db_base[attr][search_index]
		match = False
		for ptnl_match in db_to_search[attr]:	
			if ptnl_match == school_attr:
				match = True
				search_attributes = [x for x in attributes if attributes.index(x)>0]
				for extra_attr in search_attributes:
					print db_base[extra_attr][search_index]
					print ptnl_match
					print list(db_to_search[attr]).index(ptnl_match)
					
					
					
					#match_index = db_to_search[attr].index(ptnl_match)
#					if db_to_search[att][match_index] != db_base[att][search_index]:
#						match = False
#			if match == True:
#				search_ind = db_to_search[attr].index(ptnl_match)
#				print str(orig_search_db["ID"][search_ind]) + ", " + str(orig_search_db[attr][search_ind]) + ", " + str(orig_base_db["ID"][search_index]) + ", " + str(orig_base_db[attr][search_index])
#		if match == False:
#			still_missing.append(index)
	
	

#number of records in clarity that are missing from NCES

missing_names = search_list(["Name", "Type"], clarity, nces, clarity_indices, orig_clarity, orig_nces)

#print "Phone Matches"
#missing_phones = search_list(["Phone"], missing_names, clarity, nces, orig_clarity, orig_nces)
#print "Address Matches"
#missing_addresses = search_list(["Address"], missing_phones, clarity, nces, orig_clarity, orig_nces)
#file = open('non_match', 'w')
#for addr in missing_addresses:
#	file.write(list(orig_clarity["Name"])[addr]+'\n')
	#print list(orig_clarity["Name"])[addr] + " " + list(orig_clarity["Address"])[addr]