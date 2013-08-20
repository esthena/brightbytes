import csv
import pandas as pd
import sys

#files = ['parents', 'teachers', 'elem', 'ms', 'hs']
files = ['Clarity_Responses/pa_teachers']
cols = ["State", "Name", "Zip", "School ID", "Parent_Question", "Concat", "Question", "Response", "Position",
			"Count"]
for f in files:
	school_dict = {}
	file = f + '.csv'
	df = pd.read_csv(file, header=None, skiprows = 1, names = cols)
	sorted = df.sort(['Name', 'Parent_Question', 'Concat', 'Position'],ascending = [1, 1,1,1])
	no_duplicates = sorted.drop_duplicates(cols =['Parent_Question', 'Concat'], take_last=True)
	num_options = []
	for ind in range(0,len(no_duplicates['State'])):
		lst = [(str(list(no_duplicates['Parent_Question'])[ind]), str(list(no_duplicates['Concat'])[ind])),list(no_duplicates['Position'])[ind]]
		num_options.append(lst)
	for header in num_options:
		for x in range(1, header[1]+1):
			sys.stdout.write(str(header[0]) + "| " + str(x) + ",")
	print "" 
	schools = df.groupby('Name').groups
	for school in schools:
		sys.stdout.write(school + ", ")
		answers = {}
		for index in schools[school]:
			q_id = (str(list(df['Parent_Question'])[index]), str(list(df['Concat'])[index]))
			r_id = str(list(df['Position'])[index])
			key = (q_id, r_id)
			response_count = list(df['Count'])[index]
			answers[key] = response_count
		for option in num_options:
			choices = option[1]
			for x in range(1, choices+1):
				k = (option[0], str(x))
				a = answers.get(k)
				if k is None:
					print 'n/a'
				else:
					sys.stdout.write(str(a)+ "," )
		print ""

