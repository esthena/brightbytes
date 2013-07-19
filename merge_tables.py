import pandas as pd
import sys

def merge_tables(left, right, left_index, right_index, num_left, num_right, method):#, dest_file):
	left_cols = [str(x) for x in xrange(num_left)]
	right_cols = [str(x) for x in xrange(num_right)]
	
	
	def str_cast(val):
		return_val = str(val)
		return return_val

	for col in left_cols:
		left[col] = left[col].map(str_cast)
	for col in right_cols:
		right[col] = right[col].map(str_cast)
	
	df = pd.merge(left, right, left_on = left_index, right_on = right_index, how = method)
	return df
#	df.to_csv(dest_file, sep = ",", header = True)
	

ids_file = 'iowa_school_list.csv'
id_cols = [str(x) for x in xrange(12)]
join_file =  'nces_clarity_join.csv'
join_cols = [str(x) for x in xrange(2)]
clarity_file = 'headers.csv'
clarity_cols = 63
enrollment_file = 'iowa_demographics_max_ids.csv'
enrollment_cols = [str(x) for x in xrange(27)]
enrollment_index =0

ids = pd.read_csv(ids_file, header=None, names = id_cols, skiprows=0)
join = pd.read_csv(join_file, header = None, names = join_cols, skiprows = 0)
	
first = merge_tables(ids, join, '1', '1', len(id_cols), len(join_cols), 'right') 

enrollment = pd.read_csv(enrollment_file, header = None, names = enrollment_cols, skiprows=0)
second = merge_tables(first, enrollment,'1', '0', len(id_cols)+len(join_cols)-1, len(enrollment_cols), 'left')
print second[:5]

reading_file = 'iowa_reading.csv'
reading_index = 0
math_file = 'iowa_match.csv'
math_index =0
free_lunch_file = 'iowa_lunch.csv'
free_lunch_index =0
fiscal_file = 'fiscal_iowa.csv'
fiscal_index =0
grad_file = 'iowa_grads.csv'
grad_index =0