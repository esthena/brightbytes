select sr.survey_template_id, o.entity_id, sd.survey_question_id, sum((oc.option_count - so.position)*(1.0/(oc.option_count-1)))/count(*) from 
   survey_data sd
   join survey_responses sr on sr.id = sd.survey_response_id
   join organizations o on o.id = sr.organization_id and o.entity_type like 'School'
   join survey_options so on so.id = sd.survey_option_id
   join survey_questions sq on sq.id = sd.survey_question_id and sq.question_type like 'radio'
   join surveys sur on sr.survey_id = sur.id

   join (select so2.survey_question_id as survey_question_id, max(position) as option_count from survey_options so2 group by 1) as oc on oc.survey_question_id = sq.id 

 --  where sr.created_at > '2013-06-01'

where o.zip <> '99999'
and o.name not like 'Sample%'
and o.name not like 'GREAT PRAIRIE%'
and o.state not like 'AK'
and sur.name not like 'FAKE%'
   group by 1,2,3;  