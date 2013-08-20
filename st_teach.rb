require 'csv'
require 'pg'
db_connect = PG::Connection.open(:dbname => 'd1v8ku445g0he6', :password => 'p95sbafpedm32j7g4hoi38v24vq', 
			:user => 'ud1pfdkan1b0kp', :port => '5532', :host => 'ec2-54-221-211-178.compute-1.amazonaws.com')


file = File.open('/Users/esthenabarlow/Desktop/Official_Data_Sets/student_teacher_ratio.csv')
updates = Hash.new

CSV.parse(file) do |row|
	nces = row[0]
	ratio = row[1]
	updates[nces] = ratio
end

updates.each_pair do |key, value|
	schools = db_connect.exec("SELECT * from entity_dimension where nces_school_id like '" + key.to_s()+ "'")
	if schools.ntuples ==0
		next
	else
		for school in schools
			db_connect.exec("INSERT into data_values(entity_id, time_id, source_id, data_series_id, value, is_additive)
				values(" + school['id'] + ",52717,1,35452," + value + ",0)")
		end
	end
end

