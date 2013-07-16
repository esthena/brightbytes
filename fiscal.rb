require 'nokogiri'
require 'open-uri'

districts = ["1903090", "1903150", "1900032", "1920910", "1926820", "1903540", "1903660", "1903690", "1903930", "1903960", "1904380", "1921120", "1905070", "1905130", "1928560", "1999019", "1928170", "1904200", "1906270", "1907050", "1922380", "1900009", "1907900", "1907920", "1908070", "1930560", "1918960", "1908520", "1927500", "1909450", "1910050", "1911250", "1919740", "1912510", "1900040", "1910200", "1932010", "1913200", "1913320", "1914310", "1914640", "1914730", "1915210", "1926640", "1915450", "1915840", "1926850", "1916320", "1906900", "1903030", "1918180", "1918720", "1918750", "1999017", "1919590", "1920100", "1920250", "1920850", "1920610", "1921240", "1921660", "1907410", "1900025", "1922470", "1922530", "1923160", "1924870", "1931080", "1927480", "1918030", "1928020", "1914670", "1904440", "1929010", "1930510", "1930930", "1931860", "1908970", "1925320", "1928680", "1918780", "1904680", "1905430", "1905750", "1907620", "1908190", "1931890", "1911790", "1912330", "1913470", "1916110", "1905970", "1920760", "1920730", "1921210", "1921840", "1924150", "1924960", "1924750", "1925200", "1925920", "1927900", "1929100", "1911820", "1900031", "1903360", "1903850", "1918330", "1928200", "1900028", "1907380", "1914370", "1909990", "1925380", "1910950", "1925560", "1912600", "1916420", "1917880", "1930720", "1920580", "1923190", "1923220", "1924720", "1925140", "1900023", "1927390", "1920830", "1930630", "1903060", "1903450", "1903750", "1927270", "1906510", "1907080", "1907440", "1908940", "1921630", "1909120", "1909540", "1910690", "1914280", "1929760", "1911970", "1900060", "1912660", "1913080", "1913290", "1914340", "1914580", "1915180", "1915330", "1900022", "1930870", "1920190", "1920340", "1930540", "1927600", "1921000", "1928050", "1910110", "1930480", "1908310", "1910350", "1904560", "1907650", "1908130", "1909060", "1913110", "1916620", "1905940", "1919860", "1921810", "1923760", "1929280", "1903480", "1918840", "1903720", "1904020", "1904320", "1916440", "1907170", "1918630", "1910340", "1912230", "1914160", "1931290", "1915750", "1916530", "1918480", "1931950", "1931110", "1900026", "1924120", "1925590", "1931470", "1907110", "1931620", "1926400", "1925980", "1905190", "1912480", "1931020", "1906960", "1924660", "1913660", "1900015", "1926370", "1926910", "1911070", "1907470", "1912810", "1916140", "1900021", "1925050", "1906330", "1908910", "1912750", "1914880", "1900024", "1929580", "1918300", "1921600", "1925410", "1903780", "1908220", "1916680", "1904080", "1900027", "1909570", "1910710", "1913230", "1912690", "1913500", "1920670", "1917460", "1918240", "1919440", "1927990", "1924000", "1927240", "1927960", "1928230", "1929640", "1931920", "1926070", "1907350", "1926670", "1911040", "1911520", "1926250", "1912120", "1909480", "1903630", "1904650", "1931350", "1910500", "1908880", "1918540", "1906840", "1913350", "1930900", "1918510", "1910130", "1923790", "1908730", "1921060", "1926790", "1928710", "1900006", "1910410", "1918120", "1923340", "1903390", "1928110", "1914010", "1903300", "1907590", "1903570", "1904830", "1904620", "1905490", "1906660", "1906780", "1917100", "1920820", "1906540", "1914700", "1919140", "1915660", "1917250", "1919200", "1914850", "1917220", "1918690", "1919650", "1920040", "1910980", "1921720", "1929310", "1926580", "1927060", "5900196", "1926730", "1913380", "1930240", "1930750", "1931680", "1907860", "1922110", "1903270", "1928980", "1904950", "1908610", "1906750", "1906240", "1911340", "1912060", "1919710", "1919800", "1921870", "1922440", "1925620", "1926280", "1905790", "1913530", "1929490", "1908550", "1911850", "1906930", "1915630", "1918930", "1919770", "1919890", "1920460", "1929730", "1930780", "1931830", "1904740", "1904860", "1923110", "1908580", "1906000", "1906060", "1907710", "1907980", "1906810", "1920940", "1909600", "1921090", "1917820", "1917550", "1920130", "1927870", "1930990", "1931800"]
#districts = ["1903090", "1903150", "1900032"]
for d in districts
print d + ", "
	begin
		dist_id = d
		doc = Nokogiri::HTML(open('http://nces.ed.gov/ccd/districtsearch/district_detail.asp?Search=1&DistrictID='+dist_id+'&DistrictType=1&DistrictType=2&DistrictType=3&DistrictType=4&DistrictType=5&DistrictType=6&DistrictType=7&NumOfStudentsRange=more&NumOfSchoolsRange=more&details=4&ID2='+dist_id))
	
	
	rescue
		puts d
		next
	end
	if doc.text.include?("Fiscal data for this district are not available.")
		puts d
	else
	entries = doc.css('table tr td table')
	table = entries[3]
	rows = table.css('tr')


	rows_wanted = [2,5,6,7,9,11,12,13,14,15, 17, 18, 20, 21]

	for index in rows_wanted
		total = rows[index].css('td')
		tot_amt = total[2].text.gsub(",", "")
		per_stud = total[3].text.gsub(",", "")
		print tot_amt + ", "
		print per_stud
		if index!=21
			print ", "
		end
	end
	puts
	end
end