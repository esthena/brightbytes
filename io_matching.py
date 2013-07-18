import pandas as pd
import csv
import copy

col_names = ["ID", "Name", "Address", "Town", "State", "Zip", "Phone", "County", "Type", "Min_Grade", "Max_Grade"]

orig_clarity = pd.read_csv("/Users/esthenabarlow/Desktop/matching.csv", header=None, names=col_names, skiprows=1)
orig_nces = pd.read_csv("/Users/esthenabarlow/Desktop/iowa_school_list.csv", header=None, names=col_names, skiprows=1)

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
	still_missing = []
	for index in missing_indices:
		first_search_term = list(db_base[attributes[0]])[index]
		first_search_list = list(db_to_search[attributes[0]])
		index_still_missing = True
		for i in list(xrange(len(first_search_list))):
			item = first_search_list[i]
			if item == first_search_term:
				if len(attributes)==1:
					index_still_missing = False
					print str(list(orig_base_db["ID"])[index]) + ", " + str(list(orig_base_db["Name"])[index]) + ", " + str(list(orig_search_db["ID"])[i]) + ", " + str(list(orig_search_db["Name"])[i])
				else:
					match_found = True
					for other_attr in attributes:
						if list(db_base[other_attr])[index] != list(db_to_search[other_attr])[i]:
							match_found = False
					if match_found == True:
							index_still_missing = False
							print str(list(orig_base_db["ID"])[index]) + ", " + str(list(orig_base_db["Name"])[index]) + ", " + str(list(orig_search_db["ID"])[i]) + ", " + str(list(orig_search_db["Name"])[i])
		if index_still_missing:
			still_missing.append(index)
	return still_missing
	
	
missing_names = search_list(["Name", "Town"], clarity, nces, clarity_indices, orig_clarity, orig_nces)
missing_addresses = search_list(["Address", "Min_Grade"], clarity, nces, missing_names, orig_clarity, orig_nces)
missing_towns = search_list(["Address", "Town", "Type", "Min_Grade", "Max_Grade"], clarity, nces, missing_addresses, orig_clarity, orig_nces)
missing_phones = search_list(["Phone", "Max_Grade", "Min_Grade"], clarity, nces, missing_towns, orig_clarity, orig_nces)
missing = search_list(["Phone", "Min_Grade", "Max_Grade"], clarity, nces, missing_phones, orig_clarity, orig_nces)
file = open('non_match', 'w')
for ind in missing:
	file.write(list(orig_clarity["Name"])[ind]+'\n')
