require 'net/http'
require 'json'


zip = 51366
while zip < 53000
	genders = ['M', 'F']
	start = 4
	for g in genders
		tables = Array.new
		ages = ['18-24', '25-34', '35-44', '45-64', '65+']
		levels = ['<9th', 'Some HS', 'HS or GED', 'Some college', "Associate's", "Bachelor's", 'Graduate/Professional']
		table_base = 'B15001_0'
		for age in ages
			for lev in levels
				table = table_base + "%02d" % start + 'E'
				tables << table
				start +=1
			end
			start += 1
		end
		api_key = '0e909e40f2664f799a7f7865347804305a47b87c'
		base = 'http://api.census.gov/data/2011/acs5?'
		get = "="
		for table in tables
			get += table
			if !table.eql?(tables[-1])
				get += ","
			end	
		end
        puts tables
        puts
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
		start += 1
	end
	zip += 1
end