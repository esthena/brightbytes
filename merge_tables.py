import pandas as pd
import sys

def merge_tables(left_file, right_file, left_index, right_index, num_left, num_right, method, dest_file):
	left_cols = [str(x) for x in xrange(num_left)]
	right_cols = [str(x) for x in xrange(num_right)]
	
	left = pd.read_csv(left_file, header = None, names = left_cols, skiprows = 1)
	right = pd.read_csv(right_file, header = None, names = right_cols, skiprows = 0)
	def str_cast(val):
		return_val = str(val)
		return return_val
	
	
	for col in left_cols:
		left[col] = left[col].map(str_cast)
	for col in right_cols:
		right[col] = right[col].map(str_cast)
	print right.head
	print left.head

	df = pd.merge(left, right, left_on = left_index, right_on = right_index, how = method)
	df.to_csv(dest_file, sep = ",", header = True)
	
merge_tables('hs_avg.csv', 'clarity_ids.csv', '0', '2', 202, 12, 'outer', 'hs_ids.csv')
