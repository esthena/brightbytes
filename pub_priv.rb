require 'net/http'
require 'uri'
zip_codes = ['99546','99638','99547','71854','71801','71825','71826','71837','71845','71857','71858','92395','94533','94534','95129','95307','94585','95351','93036','95358','81147','20015','33408','96818','60614','60616','60651','20817','48312','48313','48317','48307','48306','48315','48042','48302','48314','48304','48316','48363','48044','48310','48323','48309','55110','55009','55923','55965','55939','55944','55955','55975','55990','55038','55932','55964','55127','55992','55956','58504','58413','58523','58506','58501','58540','58528','58503','58530','58554','58533','58535','58538','58444','58529','58544','58545','58552','58566','58463','58558','58561','58478','58568','58570','58482','58572','58573','58487','58575','58576','58577','58775','58579','58494','58495','58581','69103','68812','68856','68814','68815','69120','68801','68822','68850','68847','68845','68823','68825','68803','68824','68827','69130','68835','69142','68859','68836','68840','69138','68882','68842','69101','68833','68875','68852','68853','68879','68862','68863','68047','68866','68869','68760','68874','68878','68876','68665','68872','68873','68039','68067','68071','68883','08822','8551','07826','8822','10562','10502','10510','10522','10590','10591','44001','44011','45236','45223','45251','44125','45242','44811','44074','44131','45231','44143','44089','45140','18011','17011','19004','17013','17110','17241','17006','19422','17007','19446','17055','19468','17090','18067','18032','19095','17109','17112','18102','18104','17111','19012','17022','17339','17050','17019','17103','17028','18235','17025','19027','18964','18049','19426','18062','17070','17057','18031','17104','19438','19035','19038','17257','17062','19454','17032','17101','18101','19010','18103','19440','18056','17033','17024','18034','18037','19046','18229','18015','18069','17043','17061','18036','18109','17036','19002','19003','19006','19464','18054','17102','19066','17018','17319','17068','16652','17074','18080','18066','19456','18071','18240','18232','18210','19072','19096','19492','17249','18078','19473','16509','17255','17264','19475','17113','16868','17020','16623','17048','17023','19090','19040','18073','18041','18969','18255','19530','17365','18106','17065','79707','76667','76554','79735','79703','79830','79714','99999','79901','77493','79772','79761','76710','76703','76624','79765','76524','77084','77494','76569','79852','79720','79721','79763','76627','77449','79764','79762','76631','79701','76704','79744','79511','79731','76637','79734','79855','78593','79705','77492','77450','79756','79739','79706','76645','76692','76649','79778','75144','79745','75862','79760','79845','79843','77079','79752','76561','76932','79848','79834','79782','76880','79372','76689','79789','76693','23112','23236','23237','24059','23113','23235','23831','23225','23836','23803','23114','23234','23120','23832','23834','23838','98815','98822','98841','98862','98831']
state_codes = ['AK','AK','AK','AR','AR','AR','AR','AR','AR','AR','AR','CA','CA','CA','CA','CA','CA','CA','CA','CA','CO','DC','FL','HI','IL','IL','IL','MD','MI','MI','MI','MI','MI','MI','MI','MI','MI','MI','MI','MI','MI','MI','MI','MI','MN','MN','MN','MN','MN','MN','MN','MN','MN','MN','MN','MN','MN','MN','MN','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NJ','NJ','NJ','NJ','NY','NY','NY','NY','NY','NY','OH','OH','OH','OH','OH','OH','OH','OH','OH','OH','OH','OH','OH','OH','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','VA','VA','VA','VA','VA','VA','VA','VA','VA','VA','VA','VA','VA','VA','VA','VA','WA','WA','WA','WA','WA'] 
i=143
while i<zip_codes.length()

	zip = zip_codes[i].to_s()
	leng = zip.length()
	while leng<5
		zip = '0'+ zip
		leng = zip.length()
	end
	zip = zip_codes[i].to_s()
	v, $VERBOSE = $VERBOSE, nil
	state = state_codes[i]

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
	if public_schools_start==nil or public_schools_end == nil
		i += 1
		next
	end
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