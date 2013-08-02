
require 'net/http'
require 'uri'

i=1
while i<=ARGV[1].to_i()
	uri = URI('http://nces.ed.gov/ccd/schoolsearch/school_list.asp?')

	params = {:Search => 1, :State => ARGV[0].to_s(), :SpecificSchlTypes => "all", :IncGrade => -1, :LoGrade => -1, :HiGrade =>-1, :SchoolPageNum =>i}
	uri.query=URI.encode_www_form(params)

	response = Net::HTTP::get_response(uri)

	relev_html = response.body
	while relev_html.index('<a href="school_detail.asp?')!=nil
		v, $VERBOSE = $VERBOSE, nil
		index = relev_html.index('<a href="school_detail.asp?')
		ID_ind = relev_html.index('&ID=')
		ID = relev_html[ID_ind+4, 12]
		school_start = relev_html[index, relev_html.length()-index].index("<strong>")+8+index
		school_end = relev_html[index, relev_html.length()-index].index("</strong>")+index
		school_name = relev_html[school_start, school_end-school_start]
		zip_ind = relev_html[school_start, relev_html.length()-school_start].index("</font>")-5
		zip = relev_html[zip_ind+school_start, 5]
		puts school_name + ", " +ID + ", " +zip
		relev_html = relev_html[school_end+1, relev_html.length()-school_end]
		$VERBOSE = v
	end
	i+=1
end