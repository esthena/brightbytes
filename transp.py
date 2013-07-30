import pandas as pd

files = ['parents', 'teachers', 'elem', 'ms', 'hs']
file_dir = '/Users/esthenabarlow/Desktop/DB_Queries/'
cols = ['State', 'Name', 'Zip', 'SchoolID', 'Parent_Q_ID', 'Concat', 'Question', 'Response', 'Count']

for file in files:
	file_name = file_dir + file + '.csv'
	df = pd.read_csv(file_name, header=None, names = cols, skiprows = 1)
	df2 = df.transpose()
	new_file_name = file_dir + file + "_transp" + '.csv'
	df2.to_csv(new_file_name, ',', header=True)