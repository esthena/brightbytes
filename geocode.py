import pandas as pd
import requests
import json

cols = ["Numbers", "NCES ID", "NCES School Name", "Street Address", "Town", "State", "Zip", "Lat", "Long"]
df = pd.read_csv('/Users/esthenabarlow/Desktop/iowa_school_list_copy.csv', header = None, skiprows = 1, names = cols)

addresses = list(df['Street Address'])
towns = list(df['Town'])
states = list(df['State'])
zips_base = list(df['Zip'])
zips = [str(x) for x in zips_base]
#addresses = ['3384 Indigo Avenue']
#zips = ['50002']
#states = ['IA']

i = 0
while i < len(addresses):
	addr = addresses[i].replace(" ", "+") + ','
	town = towns[i] + ','
	state = states[i] + ','
	zip = zips[i] + ','
	r = requests.get('http://maps.google.com/maps/api/geocode/json?address=' +addr + '&components=zip:' + zip  + '&state:' + state + '&sensor=false')
	res = json.loads(r.text)
	results = res.get('results', None)
	if len(results) != 0:
		results_array = results[0]
		for dict in results_array:
			if dict == 'geometry':
				bounds = results_array[dict].get('bounds', None)
				if bounds is not None:
					northeast = bounds.get('northeast', None)
					if northeast is not None:
						lat = northeast.get('lat', 'n/a')
						lng = northeast.get('lng', 'n/a')
					else:
						continue
				else:
					continue
	
		print df['NCES School Name'][i] + ", " + str(lat) + ", " + str(lng)
		i+=1
	else:
		i+=1