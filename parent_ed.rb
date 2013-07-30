require 'net/http'
require 'json'


genders = ['M', 'F']
ages = ['18-24', '25-34', '35-44', '45-64', '65+']
levels = ['<9th', 'Some HS', 'HS or GED', 'Some college', "Associate's", "Bachelor's", 'Graduate/Professional']

zip = 51111
table_base = 'B15001_0'
while zip < 53000
	api_key = '0e909e40f2664f799a7f7865347804305a47b87c'
	base = 'http://api.census.gov/data/2011/acs5?'
	get = "="
	
	start = 3
	for g in genders
		for age in ages
			for lev in levels
				table = table_base + "%02d" % start + 'E'
				geog = 'zip+code+tabulation+area:'+zip.to_s()
				url = base + "key=" + api_key + "&get" + get + table + "&for=" + geog
				resp = Net::HTTP.get_response(URI.parse(url))
				if resp.body!=nil
					if g == genders[0] and age == ages[0] and lev==levels[0]
						print zip.to_s() + ", "
					end
					res_array = JSON.parse(resp.body)[1]
					print res_array[0]
					if g == genders[-1] and age == ages[-1] and lev == levels[-1]
						puts ""
					else
						print ", "
					end
				end
				start += 1
			end	
		end
		start +=1
	end
	zip += 1
end
