import pandas as pd
import csv
import copy

col_names = ["School ID", "Name", "Address", "Town", "State", "Zip", "Phone", "County", "Type", "Min_Grade", "Max_Grade"]

orig_clarity = pd.read_csv("/Users/esthenabarlow/Desktop/texas_clarity_list.csv", header=None, names=col_names, skiprows=0)
orig_nces = pd.read_csv("/Users/esthenabarlow/Desktop/texas_school_list.csv", header=None, names=col_names, skiprows=0)

clarity = copy.deepcopy(orig_clarity); nces = copy.deepcopy(orig_nces)

def map_replace(entry):
	problem_chars = ["'", "(", ")", ",", ".", "-", " ", "/", "JuniorHighSchool", "SeniorHighSchool", "SeniorHigh", "MiddleSchool", "HighSchool", "ElementarySchool", "Elementary", "Middle", "High", "Avenue", "Street"]
	replacement_chars = ["", "", "", "", "", "", "", "", "MS", "HS", "HS", "MS", "HS", "EL", "EL", "MS", "HS", "Ave", "St"]
	return_str = str(entry)
	for i in list(xrange(len(problem_chars))):
		return_str = return_str.replace(problem_chars[i], replacement_chars[i])
	return_str = return_str.lower()
	return return_str

for db in clarity, nces:
	db["School ID"] = db["School ID"].astype(str)
	for attr in col_names:
		db[attr] = db[attr].map(map_replace)


#creating list indices as long as the respective school lists
num_clarity_schools = len(clarity)
num_nces_schools = len(nces)
clarity_indices =  list(xrange(num_clarity_schools))
nces_indices = list(xrange(num_nces_schools))

#this method searches for instances of the given attribute at the indexes in current list
# it returns a list of all of the indices that are in db_in but missing from db_search


def search_list(attributes, db_base, db_to_search, missing_indices, orig_base_db, orig_search_db, file, all_params=False, col_names=None):
	still_missing = []
	for index in missing_indices:
		first_search_term = list(db_base[attributes[0]])[index]
		first_search_list = list(db_to_search[attributes[0]])
		index_still_missing = True
		for i in list(xrange(len(first_search_list))):
			item = first_search_list[i]
			if item == first_search_term and item != 'nan':
				if len(attributes)==1:
					if all_params:
						for col in col_names:
							file.write(str(list(orig_base_db[col])[index]) + ", ")
						for col in col_names:
							file.write(str(list(orig_search_db[col])[i]) + ", ")
						file.write('\n')
					else:
						file.write(str(list(orig_base_db["ID"])[index]) + ", " + str(list(orig_base_db["Name"])[index]) + ", " + str(list(orig_search_db["ID"])[i]) + ", " + str(list(orig_search_db["Name"])[i]) + '\n')
					index_still_missing = False
				else:
					match_found = True
					for other_attr in attributes:
						if list(db_base[other_attr])[index] != list(db_to_search[other_attr])[i] or list(db_base[other_attr])[index] == 'nan':
							match_found = False
					if match_found == True:
						index_still_missing = False
						if all_params:
							for col in col_names:
								file.write(str(list(orig_base_db[col])[index]) + ", ")
							for col in col_names:
								file.write(str(list(orig_search_db[col])[i]) + ", ")
							file.write('\n')
						else:
							file.write(str(list(orig_base_db["ID"])[index]) + ", " + str(list(orig_base_db["Name"])[index]) + ", " + str(list(orig_search_db["ID"])[i]) + ", " + str(list(orig_search_db["Name"])[i]) + '\n')
		if index_still_missing:
			still_missing.append(index)
	return still_missing
	
file = open ('master_matches.csv', 'w')
include_params = True
print len(clarity_indices)
missing_one = search_list(["Name", "Type", "Address", "Phone", "Town"], clarity, nces, clarity_indices, orig_clarity, orig_nces, file, include_params, col_names)
print len(missing_one)
missing_two = search_list(["Address", "Town", "Min_Grade", "Max_Grade", "Phone", "Type"], clarity, nces, missing_one, orig_clarity, orig_nces, file, include_params, col_names)
print len(missing_two)
missing_three = search_list(["Phone", "Min_Grade", "Max_Grade"], clarity, nces, missing_two, orig_clarity, orig_nces, file, include_params, col_names)
print len(missing_three)

#file = open('non_match.csv', 'w')
#for ind in address_matches:
#	file.write(list(orig_clarity["Name"])[ind]+'\n')
