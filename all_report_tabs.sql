select e.enabled, e.state, e.id, e.name, d.enabled, d.id, d.name, dist.school_count, s.enabled, s.id, s.name, max(Cast(q.active as integer))
from organizations s
left join questionnaires q on q.organization_id = s.id and q.active = 't'
left join relationships r on r.child_id = s.id
left join organizations d on d.id = r.parent_id and d.entity_type like 'District'
left join districts dist on dist.id = d.entity_id
left join relationships r2 on r2.child_id = s.id
left join organizations e on e.id = r2.parent_id and e.enabled = 't' and e.entity_type like 'Esa' and e.name not like 'Sunnyside%' and e.name not like 'FAKE%' and e.name not like 'Sample%'
where e.enabled = 't' or d.enabled = 't' or s.enabled = 't'
group by e.enabled, e.state, e.id, e.name, d.enabled, d.id, d.name, dist.school_count, s.enabled, s.id, s.name, dist.school_count
order by e.name, d.name



select s.enabled, s.id, s.name, max(pre_aug_sr.submitted_at), greatest(max(post_aug_sr.submitted_at), max(qr.submitted_at))
from organizations s
left join survey_responses pre_aug_sr on pre_aug_sr.organization_id = s.id and pre_aug_sr.submitted_at < '2013-08-01'
left join survey_responses post_aug_sr on post_aug_sr.organization_id = s.id and post_aug_sr.submitted_at > '2013-08-01'
left join questionnaire_responses qr on  qr.organization_id = s.id and qr.submitted_at < '2013-10-09'
where s.enabled = 't'
group by 1,2,3


-------------------------
--combined

select e.enabled, e.state, e.id, e.name, d.enabled, d.id, d.name, dist.school_count, s.enabled, s.id, s.name, max(Cast(q.active as integer)),max(pre_aug_sr.submitted_at), greatest(max(post_aug_sr.submitted_at), max(qr.submitted_at))
from organizations s
left join survey_responses pre_aug_sr on pre_aug_sr.organization_id = s.id and pre_aug_sr.submitted_at < '2013-08-01'
left join survey_responses post_aug_sr on post_aug_sr.organization_id = s.id and post_aug_sr.submitted_at > '2013-08-01'
left join questionnaire_responses qr on  qr.organization_id = s.id and qr.submitted_at < '2013-10-09'
left join questionnaires q on q.organization_id = s.id and q.active = 't'
left join relationships r on r.child_id = s.id
left join organizations d on d.id = r.parent_id and d.entity_type like 'District'
left join districts dist on dist.id = d.entity_id
left join relationships r2 on r2.child_id = s.id
left join organizations e on e.id = r2.parent_id and e.enabled = 't' and e.entity_type like 'Esa' and e.name not like 'Sunnyside%' and e.name not like 'FAKE%' and e.name not like 'Sample%'
where e.enabled = 't' or d.enabled = 't' or s.enabled = 't'
group by e.enabled, e.state, e.id, e.name, d.enabled, d.id, d.name, dist.school_count, s.enabled, s.id, s.name, dist.school_count
order by e.name, d.name
