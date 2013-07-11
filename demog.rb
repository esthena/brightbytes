require 'uri'
require 'net/http' 
	
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


pub_priv = "Public"
id = "190309000007"

uri = URI('http://nces.ed.gov/globallocator/sch_info_popup.asp?')
params = {:Type => pub_priv, :ID => id}
uri.query = URI.encode_www_form(params)

response = Net::HTTP::get_response(uri)

locale = parse_line(response.body, "Locale", "<font size='2'>", "</font></td>")
type = parse_line(response.body, "Type:&", "<font size='2'>", "</font></td>")
if pub_priv.eql?("Private")
	affiliation = parse_line(response.body, "Affiliation", "<font size='2'>", "</font></td>")
	coed = parse_line(response.body, "Student Body", "<font size='2'>", "</font></td>")
	days_in_year = parse_line(response.body, "Days in Year:", "<font size='2'>", "</font></td>")
	hours_in_day = parse_line(response.body, "Hours in Day:", "<font size='2'>", "</font></td>")
	library = parse_line(response.body, "Library", "<font size='2'>", "</font></td>")
	charter = "N/A"
end
if pub_priv.eql?("Public")
	charter = parse_line(response.body, "Charter", "<font size='2'>", "</font></td>")
	affiliation = "N/A"
	coed  = "N/A"
	days_in_year  = "N/A"
	hours_in_day = "N/A"
	library = "N/A"
end
total_students = parse_line(response.body, "Total Students:", "<font size='2'>", "</font></td>")
total_teachers = parse_line(response.body, "Total Teachers (FTE)", "<font size='2'>", "</font></td>")
ratio = parse_line(response.body, "Student/Teacher Ratio:", "<font size='2'>", "</font></td>")

race_eth_start = response.body.index("<!-- Begin Enrollment by Race/Ethnicity -->")
race_eth_end = response.body.index("<!-- Begin Enrollment by Grade -->")
r_e_table = response.body[race_eth_start, race_eth_end-race_eth_start]
keys = ["American Indian/Alaska Native", "Asian/Pacific Islander", "Hispanic", "Black, non-Hispanic", "White, non-Hispanic", "Two or More Races"]
race_eth = parse_table('<td width="65%" align="right" nowrap><font size="2"><strong>', '<td width="3%" align="right"><font size="2">', '</font></td>', keys,r_e_table)

grade_start = response.body.index("Grade Levels:")
grade_end = response.body.index("Enrollment by Grade Chart")
grade_section = response.body[grade_start, grade_end-grade_start]
grades_prec = grade_section.index("NOWRAP><strong><font size='2'>")
grades = Array.new
while grades_prec != nil
	grades << parse_line(grade_section, "NOWRAP><strong><font size='2'>", "<font size='2'>", "&nbsp;")
	grade_section = grade_section[grades_prec+1, grade_section.length()-grades_prec-1]
	grades_prec = grade_section.index("NOWRAP><strong><font size='2'>")
end
grade_section = response.body[grade_start, grade_end-grade_start]
grade_tbl = parse_table("<td align='right' width='45%'", "width='5%'><font size='2'>", "&nbsp;&nbsp;", grades, grade_section)


puts locale
puts type
puts affiliation
puts coed
puts days_in_year
puts hours_in_day
puts library
puts charter
puts total_students
puts total_teachers
puts ratio
puts race_eth
puts grade_tbl
