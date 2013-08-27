require 'net/http'
require 'json'
require 'csv'

file = File.open('/Users/esthenabarlow/Desktop/all_zips_ever.csv', 'rb')
labels = ['Median Household Size', 'Median Household Income', 'Number of Occupied Housing Units', 'Number of Housing Units', 'Non-English Speaking Population', 'Foreign-Born', 'Number of People Below the Poverty Line', 'Total Population']
puts labels.to_s()
tables = ['B25010_001E', 'B19013_001E', 'B25002_002E', 'B25002_001E', 'B16001_005E', 'B16005C_007E', 'B06012_002E', 'B01001_001E']
#tables = ['B07001_067E','B07001_003E'] 
zips = []
CSV.parse(file) do |line|
	l = line[0]
	if l == nil
		next
	end
	while l.length() < 5
		l = '0'+l
	end
	zips << l
end
for zip in zips
	api_key = '0e909e40f2664f799a7f7865347804305a47b87c'
	base = 'http://api.census.gov/data/2011/acs5?'
	get = "="
	for table in tables
		get += table
		if !table.eql?(tables[-1])
			get += ","
		end	
	end
	geog = 'zip+code+tabulation+area:'+zip.to_s()
	url = base + "key=" + api_key + "&get" + get + "&for=" + geog
	resp = Net::HTTP.get_response(URI.parse(url))
	if resp.body!=nil
		res_array = JSON.parse(resp.body)[1]
			for r in res_array
				if r == nil
					print 'na'
				else
					print r
				end
				if r!=res_array[-1]
					print ", "
				else
					puts ""
				end
			end
	end	
end
