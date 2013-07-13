require 'net/http'
require 'uri'

zip_codes = [50622,50010,51503,50002,51401,52804,50003,52501,50601,50680,51521,52201,51001,52756,50510,52531,52202,50006,52601,50511,52172,50602,52403,51002,51632,50401,52356,50009,52203,50014,52205,50035,52030,50020,50023,50158,51004,50604,50665,52544,50475,52033,50578,50514,52402,51467,50109,52353,52206,50022,52001,50025,51005,50208,50112,52162,50124,51006,50028,51445,50621,50258,50131,52040,50833,52208,52031,50421,52721,52346,50312,52032,52722,52535,52761,51105,50701,52536,51501,52726,52732,52245,50036,51234,51239,51528,51529,51104,52753,52060,51442,50321,51007,52211,50266,50317,52003,50644,52806,52728,51534,50707,52655,52729,52777,50452,52730,50853,50316,52554,50047,52310,50616,52101,51510,52002,50314,50613,52213,52742,52214,52043,50144,51040,50201,52241,52803,52625,52315,51246,50456,52132,51551,50049,51060,51439,51012,52802,52809,50315,52549,50525,50213,52645,51031,50619,51357,51338,52052,52049,52340,50428,52322,50840,50051,52405,50322,52218,50054,50168,50055,50161,50278,50056,50154,52738,50702,50501,50668,50588,52352,50058,50313,50841,50430,50311,52627,51526,51103,52136,50801,50265,50703,50063,50111,51019,52623,52537,50530,52223,52037,51334,52624,52161,50309,50323,50069,50070,50845,50624,50660,50634,51235,50071,52046,50626,52747,50674,52224,50533,50072,52041,52776,50263,50682,52064,50046,50021,50138,51201,50235,51106,50106,50141,50142,51540,51450,50583,50830,50211,52302,52553,52035,52042,50659,52748,50627,52240,51531,51532,50628,50125,50536,52316,52045,52246,52591,52233,51638,50076,50629,52556,50648,51639,52142,50436,50327,50630,52561,51653,51025,51020,50438,51237,51243,52632,50105,50541,50635,50669,51443,50632,51342,51364,52404,50107,50636,50677,51535,50638,50115,51640,50595,50441,51537,52641,50662,52620,52626,51347,50118,51346,51248,51023,52147,52065,52317,52327,50310,52235,51024,52347,51108,52656,52358,51238,50212,50230,50643,50529,50548,50257,51446,51454,51455,50325,51566,51240,50521,50126,52247,52301,51027,50320,50647,50219,50129,52411,52746,52237,50447,52151,52248,52249,51028,51250,51038,50450,52333,52057,50140,50651,52053,50554,51030,50851,51544,52567,52155,50461,50147,52253,51546,51453,52755,52754,52361,50560,50251,50156,50518,50563,51034,51035,51014,50160,50655,52157,52637,50062,50163,52401,52159,52254,52323,52362,50167,51555,50169,51041,51003,50170,50171,52571,50123,50103,52640,52572,50854,52314,51039,50174,52574,50658,50666,51247,52160,50540,50568,50849,50846,50837,50458,52337,52255,52306,52216,52750,50034,52175,50424,50478,52344,50207,50007,50226,50675,50590,50459,52318,50539,51458,51354,51351,52320,50858,52577,50216,50050,50228,52563,52580,52068,50220,51048,50225,50464,50574,50575,50523,50543,50538,50859,52069,52807,51050,50466,51053,52165,51560,51525,51109,51016,51061,50468,50579,50248,50236,50237,51358,52070,52649,50473,50535,51461,51054,52590,50670,52332,51601,51249,51652,50585,51341,50139,50145,50166,50040,51449,50130,50122,51245,51046,51637,52339,52342,51022,51301,51360,52336,50472,51573,50606,50517,52078,50249,50164,50864,52349,52772,50480,51575,51559,50255,52163,50676,52171,50044,50519,51576,52141,52551,52565,52651,50261,50482,52768,52621,52654,52773,51466,51577,52653,52170,50060,50562,50597,50250,50233,50244,52328,50469,50423,51557,50247,51055,51063,52778,52659,50273,50432,51579,50276]
i=0
while i<zip_codes.length()
	zip = zip_codes[i]
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