require 'csv'

questions = Hash.new
weights = Hash.new
w_file = File.open('/Users/esthenabarlow/Desktop/ROUND_ONE1.csv', 'rb')
CSV.parse(w_file) do |row|
	q = row[0]
	if !questions.has_key?(q)
		opts = row[5]
		questions[q] = opts
	end
	response = [q, row[3]]
	wt = row[4]
	weights[response] = wt
end


responses = Hash.new
print "State,School"
questions.each_key do |q_to_print|
	print q_to_print + "Weighted , Total, Percentage, " 
end
puts ""


#files = ['/Users/esthenabarlow/Desktop/Clarity_Responses/enabled_elem.csv', '/Users/esthenabarlow/Desktop/Clarity_Responses/enabled_ms.csv', 
#	'/Users/esthenabarlow/Desktop/Clarity_Responses/enabled_parents.csv', '/Users/esthenabarlow/Desktop/Clarity_Responses/enabled_teachers.csv',
#		 '/Users/esthenabarlow/Desktop/Clarity_Responses/enabled_hs.csv']

#files = ['/Users/esthenabarlow/Desktop/sou_leh.csv']
files = ['/Users/esthenabarlow/Desktop/responses.csv']

for file in files
	sch_file = File.open(file, 'rb')
	CSV.parse(sch_file) do |line|
		schoolid = line[3]
		name = line[1]
		state = line[0]
		id = [state, schoolid, name]
		specific_question = [line[4], line[7]]	
		resp_count = line[8]
		if responses.has_key?(id)
			sch_responses = responses[id]
			sch_responses[specific_question] = resp_count
			responses[id] = sch_responses
		else
			sch_responses = Hash.new
			sch_responses[specific_question] = resp_count
			responses[id] = sch_responses
		end
	end

end

responses.each_pair do |school, response_hash|
	print school[0] + ", " + school[2] + ","
	questions.each_key do |q|
		num_options = questions[q]
		i = 1
		weighted_average = 0
		total = 0
		while i <= num_options.to_f()
			question_id = [q, i.to_s()]
			weight = weights[question_id]
			response_count = response_hash[question_id]
			if response_count == nil
				response_count = 0
			end
			weighted_average +=  (weight.to_f()*response_count.to_f())
			total += response_count.to_f()
			i += 1
		end
		if total ==0
			flt = 0
		else		
			flt = weighted_average/total
		end
		print weighted_average.to_s() + ", " + total.to_s() + ", " + flt.to_s() + ", "
	end
	puts ""
end	