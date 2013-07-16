require 'net/http'
require 'uri'

i=50000
while i<53000
	zip = i.to_s()
	v, $VERBOSE = $VERBOSE, nil
	state = "IA"

	def parse_line(body, category, prec_text, foll_text)
		strt_ind = body.index(category)
		if strt_ind == nil
			return "N/A"
		end
		ind = body[strt_ind, body.length()-strt_ind].index(prec_text)+strt_ind+prec_text.length()
		len = body[ind, body.length()-ind].index(foll_text)
		return body[ind, len]
	end	
	def parse_table(not_null, prec_text, foll_text, keys, table)
		keyvals = Hash.new
		i = 0
		while table.index(not_null)!=nil
			num_ind = table.index(prec_text)+prec_text.length()
			num_leng = table[num_ind, table.length()-num_ind].index(foll_text)
			num = table[num_ind, num_leng]
			table = table[num_ind+num_leng, table.length()-num_ind-num_leng]
			keyvals[keys[i]]= num
			i += 1
		end
		return keyvals
	end

	uri = URI('http://nces.ed.gov/globallocator/index.asp?')
	params = {:search => 1, :State => state, :city => "", :zipcode => zip.to_s(), :miles => "", :itemname => "", :sortby => "", :School => "1", :PrivSchool => "1"}
	uri.query = URI.encode_www_form(params)

	res = Net::HTTP::get_response(uri)
	CS = parse_line(res.body, "CS", "CS=", '">here')
	params[:CS] = CS.to_s()
	uri.query = URI.encode_www_form(params)
	response = Net::HTTP::get_response(uri)


	html = response.body
	public_schools_start = response.body.index('Searching("Displaying Public Schools...")')
	public_schools_end = response.body.index("<!-- End Private Schools -->")
	public_schools = response.body[public_schools_start, public_schools_end-public_schools_start]
	while public_schools.index('class="Miles">')!=nil
		v, $VERBOSE = $VERBOSE, nil
		public_schools = public_schools[public_schools.index('class="Miles">')+1, public_schools.length()-(public_schools.index('class="Miles">')+1)]
		ID = parse_line(public_schools, "Type=", "ID=", "');")
		name = parse_line(public_schools, "Type=", ID.to_s()+"')"+';">',"</a>")
		phone = parse_line(public_schools, "Type=", zip.to_s()+"<br />", "&nbsp;&nbsp;")
		if public_schools.index('class="Miles">')==nil
			school = public_schools
		else
			school_start = public_schools.index(name)
			school_leng = public_schools[school_start, public_schools.length()-school_start].index("Type=")
			school = public_schools[school_start, school_leng]

		end
		if school.index("</strong> - <strong>")!=nil
			min_grade = parse_line(public_schools, "InstDetail", "grades: <strong>", "</strong>")
			max_grade = parse_line(public_schools, "InstDetail", "- <strong>", "</strong></td>")
		else
			grade = parse_line(public_schools, "grades:", "<strong>", "</td>")
		end
		print ID.to_s() + ", "
		print name +", "
		if public_schools.index("End Public Schools")!=nil
			type = "Public"
		else
			type = "Private"
		end
		print type+", "
		print phone+", "
		if min_grade!=nil
			print min_grade +", "
			print max_grade +", "
		else
			print grade + ","
			print grade + ","
		end
		min_grade = nil
		puts zip.to_s()
		$VERBOSE = v	
	end
	$VERBOSE = v	
	i+=1
end