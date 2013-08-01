import csv
import pandas as pd
import sys
import math

#files = ['parents', 'teachers', 'elem', 'ms', 'hs']
files = [sys.argv[1]]
cols = ["State", "Name", "Zip", "School ID", "Parent_Question", "Concat", "Question", "Response", "Position",
			"Count"]
for f in files:
	school_dict = {}
	file = f + '.csv'
	df = pd.read_csv(file, header=None, skiprows = 1, names = cols)
	sorted = df.sort(['Name', 'Parent_Question', 'Concat', 'Position'],ascending = [1, 1,1,1])
	no_duplicates = sorted.drop_duplicates(cols =['Parent_Question', 'Concat'], take_last=True)
	weight_cols = ["Parent_Question", "Concat", "Name1", "Name2", "Position", "Weight"]
	first_weights = pd.read_csv('/Users/esthenabarlow/Desktop/Clarity_Responses/radio_questions.csv', header=None, skiprows = 1, names = weight_cols)
	weights_frame = first_weights.drop_duplicates(cols = ['Parent_Question', 'Concat', 'Position'], take_last=True)
	
	num_options = []
	weights = {}
	sys.stdout.write('School Name,')
	for ind in range(0,len(no_duplicates['State'])):
		parent_q = list(no_duplicates['Parent_Question'])[ind]
		if math.isnan(parent_q):
			parent_q = -1
		concat_id = list(no_duplicates['Concat'])[ind]
		max_pos = list(no_duplicates['Position'])[ind]
		parent_matches = weights_frame[weights_frame['Parent_Question'] == parent_q]
		concat_matches = parent_matches[parent_matches['Concat'] == concat_id]
		weight_list = []
		q = (parent_q, concat_id)
		num_options.append(q)
		for x in range(1, max_pos+1):
			q_str = str(q).replace(", '|", ";").replace("'", "")
			sys.stdout.write(q_str + ";" + str(x) + " Responses, Weighted, Percentage,")
			row = concat_matches[concat_matches['Position'] == x]
			if len(row)!=0:
				weight = float(row['Weight'])
			else:
				weight = 0
			weight_list.append([x, weight])
		weights[q] = weight_list

	print ""
	schools = df.groupby('Name').groups
	for school in schools:
		sch_ind = list(df['Name']).index(school)
		sys.stdout.write(school + ", ")
		sys.stdout.write(str(list(df['School ID'])[sch_ind]) + ", ")
		answers = {}
		for index in schools[school]:
			q_id = list(df['Parent_Question'])[index]
			if math.isnan(q_id):
				q_id = -1
			c_id = list(df['Concat'])[index]
			r_id = list(df['Position'])[index]		
			response_count = list(df['Count'])[index]
			key = (q_id, c_id, r_id)
			answers[key] = response_count
		
		
		for option in num_options:
			responses = weights[option]
			weighted_avg = 0
			total = 0
			for answ in responses:
				k = option[0],option[1],answ[0]
				r_count = answers.get(k)
				if r_count == None:
					r_count = 0
				w = answ[1]
				total += r_count
				weighted_avg += (w*r_count)

			
			if total == 0:
				sys.stdout.write('n/a, n/a, n/a,')
			else:
				sys.stdout.write(str(total) + ", " + str(weighted_avg) + ", " + str(weighted_avg/total) + ", ")

		print ""