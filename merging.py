import pandas as pd
dem_cols = ["NCES School ID", "Locale","Type","Charter","Total Teachers (FTE)","Total Students","Student/Teacher Ratio","American Indian/Alaska Native","Asian/Pacific Islander", "Hispanic","Black","White", "Two or More Races","PK","KG","1st Grade","2nd Grade","3rd Grade","4th Grade","5th Grade","6th Grade","7th Grade", "8th Grade","9th Grade","10th Grade", "11th Grade","12th Grade"]
match_cols = ["Clarity ID", "Name", "NCES ID", "NCES Name"]
demographics = pd.read_csv("/Users/esthenabarlow/Desktop/iowa_demographics_max_ids.csv", header=None, names=dem_cols, skiprows=1)
good_matches = pd.read_csv("/Users/esthenabarlow/Desktop/master_matches.csv", header=None, names=match_cols, skiprows=0)
weak_matches = pd.read_csv("/Users/esthenabarlow/Desktop/weak_matches.csv", header=None, names=match_cols, skiprows=0)
all_matches = good_matches.append(weak_matches)

df = pd.merge(demographics, all_matches, left_on = "NCES School ID", right_on = "NCES ID", how = 'outer')
print df[:5]