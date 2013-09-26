select s.state, s.name, s.zip, s.schoolid, sq.parent_question_id, concat(sq.question_number, ':', sq.id),
     min(sq.name) as question, min(so.name) as response, count(*)
 from survey_data sd 
     join survey_responses sr on sr.id = sd.survey_response_id and sr.survey_template_id in (5) -- 1 = parents, 2 = teacher & admin,  3= elem, 4 = middle, 5 = hs 
     join survey_options so on sd.survey_option_id = so.id 
    
     join organizations o on  sr.organization_id = o.id and o.zip <> '99999' 
     join schools s on o.entity_type like 'School' and  o.entity_id = s.id
     join survey_questions sq on sq.id = sd.survey_question_id  and  sq.question_type like 'radio'   and sq.id = so.survey_question_id
     join surveys sur on sur.id = sr.survey_id and sur.name not like 'FAKE%'
 
  where
  -- sr.created_at > '2013-06-02' and   
  -- s.name like 'ABBIE SAWYER ELEMENTARY SCHOOL' and
   s.state like 'IA'
 GROUP BY 1,2,3,4,5,6 
  order by 1, 2,3,4,5,6
  ;


--survey questions

select sq.name, count(*)
	from survey_options so
	join survey_questions sq on so.survey_question_id = sq.id and sq.question_type like 'radio'
	group by sq.name
	order by sq.name;

	 
	 --all questions:
	 
select s.state, s.name, s.zip, s.schoolid, sq.parent_question_id, concat(sq.question_number, ':', sq.id),
     min(sq.name) as question, min(so.name) as response, so.position, count(so.name)
 from survey_data sd 
     join survey_responses sr on sr.id = sd.survey_response_id and sr.survey_template_id in (2) -- 1 = parents, 2 = teacher & admin,  3= elem, 4 = middle, 5 = hs 
     join survey_options so on sd.survey_option_id = so.id 
    
     join organizations o on  sr.organization_id = o.id and o.zip <> '99999' 
     join schools s on o.entity_type like 'School' and  o.entity_id = s.id
     join survey_questions sq on sq.id = sd.survey_question_id  and  sq.question_type like 'radio'   and sq.id = so.survey_question_id
     join surveys sur on sur.id = sr.survey_id and sur.name not like 'FAKE%'
 
  where
   --sr.created_at > '2013-06-02' and   
   --s.name like 'ALBIA HIGH SCHOOL' and
  -- s.state like 'IA'
 GROUP BY 1,2,3,4,5,6, so.name, so.position
  order by s.name, sq.parent_question_id, question, so.position
  
  
  --checkboxes
  
  select sq.name, so.name
from survey_options so
join survey_questions sq on sq.id = so.survey_question_id
where sq.question_type like 'checkbox'
and so.name not like 'Surrogate Key';