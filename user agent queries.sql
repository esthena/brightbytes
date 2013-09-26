--Browsers
select regexp_matches(raw_data, '(Safari\/[0-9]*.[0-9]*|Chrome\/[0-9]*.[0-9]*|Firefox\/[0-9]*.[0-9]*|MSIE.....)')
from survey_responses
where raw_data like '%STANDARD_USERAGENT%'
and(
not (raw_data like '%Firefox%' and raw_data not like '%Seamonkey%')
and not (raw_data like '%Chrome%' and raw_data not like '%Chromium%')
and not (raw_data like '%Safari%' and raw_data not like '%Chrome%' and raw_data not like '%Chromium%')
and not (raw_data like '%MSIE%')
);

--empty
select regexp_matches(raw_data, '(STANDARD_USERAGENT......"")')
from survey_responses
where raw_data like '%STANDARD_USERAGENT%'
