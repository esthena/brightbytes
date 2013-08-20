require 'csv'
require 'pg'

db_connect = PG::Connection.open(:dbname => 'd1v8ku445g0he6', :password => 'p95sbafpedm32j7g4hoi38v24vq', 
			:user => 'ud1pfdkan1b0kp', :port => '5532', :host => 'ec2-54-221-211-178.compute-1.amazonaws.com')


file = File.open('/Users/esthenabarlow/Desktop/Official_Data_Sets/join_table.csv')
updates = Hash.new

CSV.parse(file) do |row|
	clarity = row[0]
	nces = row[1]
	updates[clarity] = nces
end

updates.each_pair do |key, value|
	db_connect.exec("UPDATE entity_dimension SET nces_school_id = '" + value + "' WHERE entity_id = " + key)
end

