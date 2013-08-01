import pandas as pd

#cols = ["Numbers", "NCES ID", "NCES School Name", "Street Address", "Town", "State", "Zip", "Phone", "County", "Type", "Min_Grade", "Max_Grade"]
#iowa = pd.read_csv('/Users/esthenabarlow/Desktop/iowa_school_list.csv', header= None, names =  cols, skiprows = 1)

cols = ["Numbers","Min_Grade", "Max_Grade"]
iowa = pd.read_csv('/Users/esthenabarlow/Desktop/all_ranges.csv', header=None, names = cols, skiprows = 1)

print iowa[:5]
exit()


def col_cast(val):
    ret0 = val.replace(' ', '')
        ret1 = ret0.replace('KG', '0')
        ret2 = ret1.replace('PK', '0.5')
        return float(ret2)

min_grades = list(iowa["Min_Grade"].map(col_cast))
max_grades = list(iowa["Max_Grade"].map(col_cast))
iowa["Grade Category"] = list(iowa["Numbers"])

print iowa[:10]

def grade_cat(ind):
	ind -=1
	if min_grades[ind] >= 0 and max_grades[ind] <=.5:
		return 0
	else:
		if min_grades[ind]>= 6 and max_grades[ind] <= 10:
			return 2
		else:
			if min_grades[ind]>= 0 and max_grades[ind] <= 6:
				return 1
			else:
				if min_grades[ind]>= 9 and max_grades[ind] <= 12:
					return 3
				else:
					if min_grades[ind]>= 0 and max_grades[ind] <= 9:
						return 4
					else:
						if min_grades[ind]>= 6 and max_grades[ind] <= 12:
							return 5
						else:
							return 6

for i in xrange(len(iowa["Numbers"])):
	iowa['Grade Category'][i] = grade_cat(iowa["Numbers"][i])
iowa.to_csv('/Users/esthenabarlow/Desktop/grades_fixed.csv', ",", header=True)
