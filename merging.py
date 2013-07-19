import pandas as pd

#dem_cols = ["NCES School ID", "Locale","Type","Charter","Total Teachers (FTE)","Total Students","Student/Teacher Ratio","American Indian/Alaska Native","Asian/Pacific Islander", "Hispanic","Black","White", "Two or More Races","PK","KG","1st Grade","2nd Grade","3rd Grade","4th Grade","5th Grade","6th Grade","7th Grade", "8th Grade","9th Grade","10th Grade", "11th Grade","12th Grade"]
#match_cols = ["Clarity ID", "NCES ID"]

##merged_cols = [str(x) for x in xrange(30)]
##clarity_cols = [str(x) for x in xrange(63)]

#demographics = pd.read_csv("/Users/esthenabarlow/Desktop/iowa_demographics_max_ids.csv", header=None, names=dem_cols, skiprows=1)
#matches = pd.read_csv("/Users/esthenabarlow/Desktop/nces_clarity_join.csv", header=None, names=match_cols, skiprows=0)

##merged_ia = pd.read_csv("/Users/esthenabarlow/Desktop/merged_iowa.csv", header=None, names = merged_cols)
##clarity = pd.read_csv("/Users/esthenabarlow/Desktop/headers.csv", header=None, names = clarity_cols)

##df = pd.merge(merged_ia, clarity, left_on = "28", right_on = "5", how = 'inner') 
#df = pd.merge(demographics, matches, left_on = "NCES School ID", right_on = "NCES ID", how = 'inner')


merged_cols = [str(x) for x in xrange(93)]
new_cols = [str(x) for x in xrange(12)]

merged = pd.read_csv("/Users/esthenabarlow/Desktop/further_merged_iowa.csv", header=None, names=merged_cols, skiprows=1)
new = pd.read_csv("/Users/esthenabarlow/Desktop/iowa_school_list.csv", header=None, names=new_cols, skiprows=1)
def down_case(val):
	return_val = str(val)
	return return_val

for col in merged_cols:
	merged[col] = merged[col].map(down_case)
for col in new_cols:
	new[col] = new[col].map(down_case)

df = pd.merge(merged, new, left_on = "1", right_on = "1", how = 'outer')
df.to_csv('/Users/esthenabarlow/Desktop/final_merged.csv', sep=',',header=True)