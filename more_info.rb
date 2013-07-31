require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'roo'
zip_codes = ['99546','99638','99547','71854','71801','71825','71826','71837','71845','71857','71858','92395','94533','94534','95129','95307','94585','95351','93036','95358','81147','20015','33408','96818','60614','60616','60651','20817','48312','48313','48317','48307','48306','48315','48042','48302','48314','48304','48316','48363','48044','48310','48323','48309','55110','55009','55923','55965','55939','55944','55955','55975','55990','55038','55932','55964','55127','55992','55956','58504','58413','58523','58506','58501','58540','58528','58503','58530','58554','58533','58535','58538','58444','58529','58544','58545','58552','58566','58463','58558','58561','58478','58568','58570','58482','58572','58573','58487','58575','58576','58577','58775','58579','58494','58495','58581','69103','68812','68856','68814','68815','69120','68801','68822','68850','68847','68845','68823','68825','68803','68824','68827','69130','68835','69142','68859','68836','68840','69138','68882','68842','69101','68833','68875','68852','68853','68879','68862','68863','68047','68866','68869','68760','68874','68878','68876','68665','68872','68873','68039','68067','68071','68883','08822','8551','07826','8822','10562','10502','10510','10522','10590','10591','44001','44011','45236','45223','45251','44125','45242','44811','44074','44131','45231','44143','44089','45140','18011','17011','19004','17013','17110','17241','17006','19422','17007','19446','17055','19468','17090','18067','18032','19095','17109','17112','18102','18104','17111','19012','17022','17339','17050','17019','17103','17028','18235','17025','19027','18964','18049','19426','18062','17070','17057','18031','17104','19438','19035','19038','17257','17062','19454','17032','17101','18101','19010','18103','19440','18056','17033','17024','18034','18037','19046','18229','18015','18069','17043','17061','18036','18109','17036','19002','19003','19006','19464','18054','17102','19066','17018','17319','17068','16652','17074','18080','18066','19456','18071','18240','18232','18210','19072','19096','19492','17249','18078','19473','16509','17255','17264','19475','17113','16868','17020','16623','17048','17023','19090','19040','18073','18041','18969','18255','19530','17365','18106','17065','79707','76667','76554','79735','79703','79830','79714','99999','79901','77493','79772','79761','76710','76703','76624','79765','76524','77084','77494','76569','79852','79720','79721','79763','76627','77449','79764','79762','76631','79701','76704','79744','79511','79731','76637','79734','79855','78593','79705','77492','77450','79756','79739','79706','76645','76692','76649','79778','75144','79745','75862','79760','79845','79843','77079','79752','76561','76932','79848','79834','79782','76880','79372','76689','79789','76693','23112','23236','23237','24059','23113','23235','23831','23225','23836','23803','23114','23234','23120','23832','23834','23838','98815','98822','98841','98862','98831']
state_codes = ['AK','AK','AK','AR','AR','AR','AR','AR','AR','AR','AR','CA','CA','CA','CA','CA','CA','CA','CA','CA','CO','DC','FL','HI','IL','IL','IL','MD','MI','MI','MI','MI','MI','MI','MI','MI','MI','MI','MI','MI','MI','MI','MI','MI','MN','MN','MN','MN','MN','MN','MN','MN','MN','MN','MN','MN','MN','MN','MN','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','ND','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NE','NJ','NJ','NJ','NJ','NY','NY','NY','NY','NY','NY','OH','OH','OH','OH','OH','OH','OH','OH','OH','OH','OH','OH','OH','OH','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','PA','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','TX','VA','VA','VA','VA','VA','VA','VA','VA','VA','VA','VA','VA','VA','VA','VA','VA','WA','WA','WA','WA','WA'] 



def insert_comma(text, find, len)
	index = text.index(find)
	if index==nil
		return false
	else
		text.insert(index+len, ", ")
		return true
	end
end

indicator=0
while indicator < zip_codes.length()
	state = state_codes[indicator]
	zip = zip_codes[indicator].to_s()
	leng = zip.length()
	while leng<5
		zip = '0'+ zip
		leng = zip.length()
	end
	uri = URI('http://nces.ed.gov/globallocator/index.asp?')
	params = {:search => 1, :State => state, :zipcode => zip.to_s(), :School => 1, :PrivSchool =>1}
	uri.query = URI.encode_www_form(params)

	res = Net::HTTP::get_response(uri)
	res_html = Nokogiri::HTML(res.body)
	new_uri = 'http://nces.ed.gov/globallocator/index.asp?'+ res_html.css('a')[0]['href']
	begin
		html = Nokogiri::HTML(open(new_uri))
	rescue Errno::ECONNRESET
		puts zip
		next	
	end
	names = html.xpath('//td[@class="InstDesc"]')
	details = html.xpath('//td[@class="InstDetail"]')
	for name in names
		name_str = name.to_s()
		name_txt = name.text
		name_strt = name_str.index(');">')
		name_end = name_str.index("</a><br>")
		if name_strt!=nil and name_end!=nil
			name_txt = name.text
			name_txt.insert(name_end-name_strt-4, ", ")
			if insert_comma(name_txt, zip.to_s(), 5)
				if insert_comma(name_txt, " "+state+" ", 3)
					if insert_comma(name_txt, '(', 14)
						links = name.xpath('a[@href]')
						url = links[0]["href"]
						grades = name.parent().css('strong')
						if grades[0].text.eql?("Coed") or grades[0].text.eql?("All Female") or grades[0].text.eql?("All Male")
							i=1
						else
							i=0
						end
						if grades[i+1] == nil
							k=i
						else
							k=i+1
						end
						print url[url.index("ID=")+3, url.length()-url.index("ID=")-6] + ", "
						print name_txt + ", "
						if url.include?("Private")
							print "Private, "
						end
						if url.include?("Public")
							print "Public, "
						end
						puts grades[i].text + ", " + grades[k].text
					end
				end
			end
		end
	end
	indicator += 1
end