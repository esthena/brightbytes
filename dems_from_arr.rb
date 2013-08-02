require 'open-uri'
require 'nokogiri'
require 'net/https'
require 'uri'
require 'csv'

file_name = ARGV[0]
if ARGV.length()<1
	puts "Usage: 'ruby dems_from_arr.rb <filename>' where the filename is a csv file with IDs in column 1 and school type in column 10"
	exit()
end
fields = ["NCES School ID", "Locale", "Type", "Charter", "Total Teachers (FTE)", "Total Students", "Student/Teacher Ratio", "American Indian/Alaska Native", "Asian/Pacific Islander", "Hispanic", "Black, non-Hispanic", "White, non-Hispanic", "Two or More Races", "PK", "KG", "1st Grade", "2nd Grade", "3rd Grade", "4th Grade", "5th Grade", "6th Grade", "7th Grade", "8th Grade", "9th Grade", "10th Grade", "11th Grade", "12th Grade"]
arr_of_arrs = CSV.read("/Users/esthenabarlow/Desktop/"+ file_name)
ids = arr_of_arrs.map {|row| row[0]}
#types = arr_of_arrs.map {|row| row[9]}
k=1
while k<ids.length()
	line = Hash.new
	id = ids[k].to_s()
	if id.length<8
		zeroes_needed = 8-id.length()
		m = 1
		while m<=zeroes_needed
			id = '0' + id
			m+=1
		end
	end
    #	type = types[k].strip
    type = 'Public'
begin
	doc = Nokogiri::HTML(open('http://nces.ed.gov/globallocator/sch_info_popup.asp?Type='+type+"&ID=" +id, 'User-Agent'=> 'ruby'))
rescue
	puts id
	k+=1
	next
end
	line["NCES School ID"] = id
	entries = doc.css('table center table tr td table tr')
	for entry in entries
		datapt = entry.text
		split = datapt.index(":")
		categ = datapt[0, split]
		val = datapt[split+3, datapt.length()-split-3]
		line[categ.to_s()]=val
	end

	eths = ["American Indian/Alaska Native", "Asian/Pacific Islander", "Hispanic", "Black, non-Hispanic", "White, non-Hispanic", "Two or More Races"]
	race_counts = doc.css('table table table td').select{|cell| cell['width']=="3%" and cell['align']=="right"}
	index = 0
	for count in race_counts
		line[eths[index]]=count.text.to_i()
		index+=1
	end
	
	grades = Array.new
	grade_counts = doc.css('table table table table tr td')
	for count in grade_counts
		if count.css('td').length()==0
			grades << count.text
		end
	end
	i=0
	while i<grades.length()
		line[grades[i][0, grades[i].length()-2]] = grades[i+1].to_i()
		i+=2
	end
	for field in fields
		if line.has_key?(field)
			print line[field]
		else
			print "N/A"
		end
		if !field.eql?("12th Grade")
			print ", "
		end
	end
	puts
	k+=1
end