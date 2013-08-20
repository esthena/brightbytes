require 'pg'
#db_connect = PG::Connection.open(:dbname => 'd1v8ku445g0he6', :password => 'p95sbafpedm32j7g4hoi38v24vq', 
#			:user => 'ud1pfdkan1b0kp', :port => '5532', :host => 'ec2-54-221-211-178.compute-1.amazonaws.com')
#response = db_connect.exec('SELECT * from time_dimension')
#for r in response
#	puts r
#end

db_connect = PG::Connection.open(:dbname =>'testdb', :host => 'localhost', :password => 'esthena', :user => 'postgres')
#response = db_connect.exec('SELECT * from source_dimension')
resp = db_connect.exec("select * from data_series_dimension")
i=0
while i<9878909
	puts resp[i]
	i+=1require 'pg'
#db_connect = PG::Connection.open(:dbname => 'd1v8ku445g0he6', :password => 'p95sbafpedm32j7g4hoi38v24vq', 
#			:user => 'ud1pfdkan1b0kp', :port => '5532', :host => 'ec2-54-221-211-178.compute-1.amazonaws.com')
#response = db_connect.exec('SELECT * from time_dimension')
#for r in response
#	puts r
#end

db_connect = PG::Connection.open(:dbname =>'testdb', :host => 'localhost', :password => 'esthena', :user => 'postgres')
#response = db_connect.exec('SELECT * from source_dimension')
tables = db_connect.exec("select * from information_schema.tables where table_schema = 'public'")
for t in tables
	db_connect.exec("drop table " + t["table_name"])
end

db_connect.exec("create table time_dimension (id serial primary key not null, 
                             date_yyyy int,
                             date_mm int, 
                             granularity character varying (50), -- create type time_granularity as enum ('decade', '2years', 'year', 'semi-annual', 'quarterly', 'monthly', 'semi-monthly', 'weekly', 'daily');
                             months_into_school_year int);
							create index on time_dimension (date_yyyy);
							create index on time_dimension (date_mm);
							create index on time_dimension (granularity);
							create index on time_dimension (months_into_school_year);")
db_connect.exec("CREATE TABLE entity_dimension 
(
  id serial PRIMARY KEY NOT NULL ,
  
                            name character (255) NOT NULL,
 
                            entity_id integer,
 
                            entity_type character varying (25),
  -- create type entity_typ as enum ('School', 'District', 'State', 'Country', 'Zip', 'Zcta', 'Esa');
                          	state character varying (60) ,
 
			
  				city character varying (60),
 
			  				country character varying (40),
		    				zip character varying (20),

                          	phone character varying (35),
                          	nces_school_id bigint,
                          	nces_district_id bigint);  

							create index on entity_dimension (name);
							create index on entity_dimension (entity_id);
							create index on entity_dimension (entity_type, entity_id);
							create index on entity_dimension (state, city);
							create index on entity_dimension (zip);
							create index on entity_dimension (nces_school_id);
							create index on entity_dimension (nces_district_id);

							CREATE TABLE source_dimension ( id serial PRIMARY KEY NOT NULL,
							name character varying (255) not null,
							url character varying (8000),
							loader character varying (255),
							load_date timestamp);

							create index on source_dimension (name);
							create index on source_dimension (url);

							CREATE TABLE data_series_dimension (id serial PRIMARY KEY NOT NULL,
				    		name character varying (1000),
				    		reference_group character varying (100), -- ('parents', 'teachers', 'whole population', 'pre-k', 'k', '1st', '2nd', 
									     --  '3rd', '4th', '5th', '6th', '7th', '8th', '9th', '10th', '11th', '12th', 'elementary', 'middle', 'high', 'staff');
				    		demographics_id integer);

							create index on data_series_dimension (name);
							create index on data_series_dimension (reference_group);
							create index on data_series_dimension (demographics_id);


							CREATE TABLE demographics_dimension (id serial PRIMARY KEY NOT NULL, 
							ethnicity character varying (40), --  ( 'American Indian/Alaska Native', 'Asian or Asian/Pacific Islander', 'Hispanic', 'Black', 'White', 'Hawaiian Nat./Pacific Isl.', 'Two or More Races');
        					hispanic character varying (25), --('yes', 'no, 'unknown'),
							gender character varying (25), -- enum ('male', 'female', 'unknown'),
     					    socio_economic character varying (25),  -- ('Free Lunch Eligible', 'Reduced Lunch Eligible', 'No assistance', 'Unknown'),
        					special_needs character varying (25), -- ( 'Unknown', 'None', 'Visual', 'Hearing', 'Mobility', 'Cognitive', 'Behavioral/Social'),
					        country_of_birth character varying (100), -- ( 'USA', 'Mexico', 'Philippines' , 'China', 'India', 'Vietnam', 'Dominican Republic', 'El Salvador', 'Cuba', 'Korea', 'Haiti', 'Jamaica', 'Colombia', 'Russia', 'Canada', 'United Kingdom', 'Poland', 'Iran', 'Guatemala', 'Pakistan', 'Peru', 'Other North American', 'Other South American', 'Other European', 'Other African', 'Other Asian', 'Other Australian'),
        					english_in_home character varying (25), -- enum ('exclusively', 'primarily', 'limited', 'none', 'unknown')
        					age_group character varying (20)
        					);

							create index on demographics_dimension (ethnicity);
							create index on demographics_dimension (hispanic);
							create index on demographics_dimension (gender);
							create index on demographics_dimension (socio_economic);
							create index on demographics_dimension (special_needs);
							create index on demographics_dimension (country_of_birth);
							create index on demographics_dimension (english_in_home);

							CREATE TABLE data_values (entity_id integer NOT NULL,
                          	time_id integer NOT NULL,
                          	source_id integer NOT NULL,
                          	data_series_id integer NOT NULL,
			  				value float NOT NULL,
			  				is_additive smallint NOT NULL default 0);"
			  				)


data_categories = {'Enrollment' => 1, 'FTE_Teachers'=> 1, 'Student_Teacher_Ratio' => 0, 
'Geography' => 0, 'Charter_Flag' => 0, 'Magnet_Flag' => 0, 'Title_1_Flag'=>0, 
'Minimum_Grade'=>0, 'Maximum_Grade'=>0, 'Schools_in_District'=>1, 
'English_Lanuage_Learners' => 1, 'Special_Education_Students' => 1, 
'Median_Household_Income' => 0, 'Free_Reduced_Lunch' => 1, 'Years_of_Ed_Post_Grade_8' => 1,
'Household_Size' => 0, 'Home_Ownership' => 1, 'Per_Pupil_Expenditure' => 0, 
'Per_Pupil_Tech_Expenditure' => 0, 'Total_Expenditure' => 0, 'Proficient_Math' => 1, 
'Proficient_Reading' => 1, 'Proficient_Science' => 1, 'Graduates' => 1, 
'Students_In_Art_Programs' => 1, 'Students_In_Fitness_Programs'=>1, 'Art_Program?' => 0,
'Fitness_Program?' =>0,'Employment' => 1, 'Population_Size' =>1, 'Foreign_Born' => 1, 
'Student_Mobility' => 1}

reference_groups = ['parents', 'teachers', 'whole population', 'pre-k', 'k', '1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th', '9th', '10th', '11th', '12th', 'elementary', 'middle', 'high', 'staff']


data_categories.each_pair do |key, value|
	for group in reference_groups
		dem_id = 1
		while dem_id <= 9878908 # 8*28*7*4*3*3*5*35
			db_connect.exec("insert into data_series_dimension(name, reference_group, demographics_id) values ('" + key.to_s() + "', '" + group.to_s() + "', " + dem_id.to_s() + ")")
			dem_id += 1
		end
	end
end			
	

ethnicities = ["Unknown", "American Indian/Alaska Native", "Asian or Asian/Pacific Islander", "Hispanic", "Black", "White", "Hawaiian Nat./Pacific Isl.", "Two or More Races"]
birth_countries = ["Unknown", "USA", "Mexico", "Philippines" , "China", "India", "Vietnam", "Dominican Republic", "El Salvador", "Cuba", "Korea", "Haiti", "Jamaica", "Colombia", "Russia", "Canada", "United Kingdom", "Poland", "Iran", "Guatemala", "Pakistan", "Peru", "Other North American", "Other South American", "Other European", "Other African", "Other Asian", "Other Australian"];
special_needs = ["Unknown", "None", "Visual", "Hearing", "Mobility", "Cognitive", "Behavioral/Social"]
socio_economic = ["Free Lunch Eligible", "Reduced Lunch Eligible", "No assistance", "Unknown"]
hispanic = ["Yes", "No", "Unknown"]
gender = ["Male", "Female", "Unknown"]
english_at_home = ["Exclusively", "Primarily", "Limited", "None", "Unknown"]
ages = ['Under 5 years', '5 to 9 years', '10 to 14 years', '15 to 17 years', '18 to 19 years',
		'20 years', '21 years', '25 to 29 years', '30 to 34 years', '35 to 39 years', 
		'40 to 44 years', '45 to 49 years', '50 to 54 years', '55 to 59 years', '60 to 61 years',
		'62 to 64 years', '65 to 66 years', '67 to 69 years', '70 to 74 years', '75 to 79 years',
		'80 to 84 years', '85 years and over', 'Under 5 years', '5 years', '6 to 11 years', 
		'12 to 14 years', '15 years', '16 and 17 years', '18 to 24 years', '25 to 34 years', 
		'35 to 44 years', '45 to 54 years', '55 to 64 years', '65 to 74 years', '75 years and over']

for eth in ethnicities
	for country in birth_countries
		for need in special_needs
			for status in socio_economic
				for hisp in hispanic
					for gen in gender
						for english_level in english_at_home
							for age in ages
								q = "insert into demographics_dimension(ethnicity, hispanic, gender, socio_economic, special_needs, country_of_birth, english_in_home, age_group) values ('" + eth + "','" + hisp + "','" + gen + "','" + status + "','" + need + "','" +  country+ "','" + english_level + "','" + age+ "')";
								db_connect.exec(q)
							end
						end
					end
				end
			end
		end
	end
end

response = db_connect.exec("select * from demographics_dimension")
for r in response
	puts r
end

end