select e.enabled, e.state, e.id, e.name, d.enabled, d.id, d.name, dist.school_count, s.enabled, s.id, s.name, max(qr.submitted_at)
from questionnaire_responses qr 
right outer join organizations s on s.id = qr.organization_id
right outer join relationships r on r.child_id = s.id
right outer join organizations d on d.id = r.parent_id
right outer join districts dist on dist.id = d.entity_id
right outer join relationships r2 on r2.child_id = d.id
right outer join organizations e on e.id = r2.parent_id
where d.entity_type like 'District'
and e.enabled = 't'
and e.entity_type like 'Esa'
and e.name not like 'Sunnyside%'
and e.name not like 'FAKE%'
and e.name not like 'Sample%'
group by e.enabled, e.state, e.id, e.name, d.enabled, d.id, d.name, dist.school_count, s.enabled, s.id, s.name, dist.school_count

-----------------------
--tab 2, enabled, school level
select e.id, e.name, e.enabled, d.state, d.id, d.name, d.enabled, dist.school_count, s.id, s.enabled, s.name, max(qr.submitted_at)
from questionnaire_responses qr
right outer join organizations s on s.id = qr.organization_id
right outer join relationships r on r.child_id = s.id
right outer join organizations d on d.id = r.parent_id
right outer join districts dist on dist.id = d.entity_id
left outer join relationships r3 on r3.child_id = d.id
left outer join organizations e on e.id = r3.parent_id
where d.entity_type like 'District'
and d.enabled = 't'
and d.name not like 'Sample%'
and (d.id not in (select r.child_id from relationships r) or d.id not in (select r2.child_id from
 relationships r2 join organizations o2 on o2.id = r2.parent_id where o2.enabled = 't' and o2.entity_type like 'Esa'))
group by e.id, e.name, e.enabled, d.state, d.id, d.name, d.enabled, dist.school_count, s.id, s.enabled, s.name
order by d.name

------------------------
--tab 3
select s.state, s.id, s.name, s.enabled, max(qr.submitted_at)
from organizations s
join questionnaire_responses qr on qr.organization_id = s.id
where s.id not in (select r.child_id from relationships r join organizations o2 on o2.id = r.parent_id where o2.enabled = 't')
group by s.id, s.name, s.enabled
order by s.id

------------------------
--tab 1b
select s.state, s.id,  s.name, s.enabled, max(qr.submitted_at)
from organizations s
join questionnaire_responses qr on qr.organization_id = s.id
where s.id not in (select r.child_id from relationships r join organizations o2 on o2.id = r.parent_id where o2.enabled = 't' and o2.entity_type like 'District')
and s.id in (select r2.child_id from relationships r2 join organizations o3 on o3.id = r2.parent_id where o3.enabled = 't' and o3.entity_type like 'Esa')
group by s.id, s.name, s.enabled
order by s.id



