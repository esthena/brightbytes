require 'csv'

#read in the weights
weights = Hash.new
weights_file = CSV.read('/Users/Esthena/Dropbox/EBDesktop/coefficients/question_weight_input.csv')
weights_file.shift
weights_file.each do |row|
	q_id = row[0]
	arr = row.slice(1,7)
	weights[q_id] = arr
end

def options_count arr
	count = 0
	for a in arr
		if !a.eql?(nil)
			count +=1
		end
	end
	return count
end


#response_file = CSV.read('/Users/Esthena/Dropbox/EBDesktop/coefficients/all_response_counts.csv')
response_file = CSV.read('/Users/Esthena/Dropbox/EBDesktop/cedar_falls/cf_responses.csv')
current_school_id = ""
response_file.each do |row|
	if row[0].to_i() > 600
		current_school_id = row[0]
		school_responses = Hash.new
	else
		q_id = row[0]
		counts = row.slice(1,7)
		total = row[8].to_f()
		q_wts = weights[q_id]
		if q_wts == nil
			next
		end
		q_score = 0
		i = 0
		while i < options_count(q_wts)
			q_score += counts[i].to_f()*q_wts[i].to_f()/100/total
			i+=1
		end
		puts current_school_id.to_s() + "," + q_id.to_s() + "," + q_score.to_s()
	end
end