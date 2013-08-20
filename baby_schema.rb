require 'pg'
db_connect = PG::Connection.open(:dbname => 'd1v8ku445g0he6', :password => 'p95sbafpedm32j7g4hoi38v24vq', 
			:user => 'ud1pfdkan1b0kp', :port => '5532', :host => 'ec2-54-221-211-178.compute-1.amazonaws.com')

data_categories = ["Enrollment", "FTE Teachers", "Geography"]
reference_groups = ['pre-k', 'k', '1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th', '9th', '10th', '11th', '12th']
ethnicities = ["Unknown", "American Indian/Alaska Native", "Asian or Asian/Pacific Islander", "Hispanic", "Black", "White", "Hawaiian Nat./Pacific Isl.", "Two or More Races"]
gender = ["Male", "Female", "Unknown"]
birth_countries = ["Unknown"]
special_needs = ["Unknown"]
socio_economic = ["Unknown"]
hispanic = ["Unknown"]
english_at_home = ["Unknown"]
ages = ["Unknown"]
=begin
for eth in ethnicities
	for country in birth_countries
		for need in special_needs
			for status in socio_economic
				for hisp in hispanic
					for gen in gender
						for english_level in english_at_home
							for age in ages
								puts eth.to_s() + ", " + gen.to_s()
								q = "insert into demographics_dimension(ethnicity, hispanic, gender, socio_economic, special_needs, country_of_birth, english_in_home, age_group) values ('" + eth + "','" + hisp + "','" + gen + "','" + status + "','" + need + "','" +  country+ "','" + english_level + "','" + age+ "')";
								puts q
								db_connect.exec(q)
							end
						end
					end
				end
			end
		end
	end
end
=end
ids = db_connect.exec("SELECT id from demographics_dimension")
dem_ids = Array.new
for id in ids
	dem_ids << id['id']
end

for cat in data_categories
	for group in reference_groups
		for dem_id in dem_ids
			db_connect.exec("insert into data_series_dimension(name, reference_group, demographics_id) values ('" + cat + "', '" + group + "', '" + dem_id + "')")
		end
	end
end
