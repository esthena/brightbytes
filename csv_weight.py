import csv
import math
import sys

questions_file = 'radio_questions.csv'

weights_file = '/Users/esthenabarlow/Desktop/Clarity_Responses/' + questions_file
with open(weights_file, 'rU') as weights_csv:
	weightsreader = csv.reader(weights_csv, delimiter=',')
	questions = []
	weights = {}
	header = weightsreader.next()
	for row in weightsreader:
		q = (row[0], row[1])
		w = (row[4], row[5])
		if weights.get(q) is None:
			weights[q] = [w]
		else:
			wts = weights[q]
			weights[q] = wts.append('lolz wut' + str(w))
	for weight in weights:
		if weights[weight] == None:
			print weight
exit()		
filename = '/Users/esthenabarlow/Desktop/Clarity_Responses/'+sys.argv[1] +'.csv'
with open(filename, 'rb') as csvfile:
	schoolreader = csv.reader(csvfile, delimiter=',')
	header = schoolreader.next()
	row = schoolreader.next()
	key = (row[4], row[5])
	id = row[3]
