require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'roo'

def insert_comma(text, find, len)
	index = text.index(find)
	if index==nil
		return false
	else
		text.insert(index+len, ", ")
		return true
	end
end


zip = 77494
while zip<80000
	state = "TX"
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
	zip += 1
end