select parent.id, parent.enabled, parent.name, o.state, o.created_at, o.updated_at, o.entity_type, o.id, o.name
from organizations o
left outer join relationships r on r.child_id = o.id
left outer join organizations parent on parent.id = r.parent_id
where o.enabled = 't'
and (o.id not in (select r.child_id from relationships r) or o.id in (select r2.child_id from
 relationships r2 join organizations o2 on o2.id = r2.parent_id where o2.enabled = 'f' and o2.entity_type like 'District') or 
 o.id in (select r2.child_id from relationships r2 join organizations o2 on o2.id = r2.parent_id where o2.enabled = 'f' and o.entity_type
  like 'District' ))
and o.name not like 'Sample%'
and o.name not like 'Aleutian%'
and o.name not like 'Annette%'
and o.entity_type not like 'State'
and o.entity_type not like 'Esa'
and (parent.id <> 148696 or parent.id is null)
and (parent.enabled = 'f' or parent.enabled is null)
and o.entity_type not like 'State'
order by parent.name

---------------------------------------------------------

select e.id, e.name, d.id, d.name, dist.school_count, count(distinct s.id), max(sr.submitted_at)
from survey_responses sr
join organizations s on s.id = sr.organization_id
right outer join relationships r1 on r1.child_id = s.id
right outer join organizations d on d.id = r1.parent_id
right outer join relationships r2 on r2.child_id = d.id
right outer join organizations e on e.id = r2.parent_id
right outer join districts dist on dist.id = d.entity_id
where (e.entity_type like 'Esa' or e.entity_type is null) 
and (d.entity_type like 'District' or d.entity_type is null)
and (s.entity_type like 'School')
and (e.enabled = 't' or e.enabled is null)
and (e.name not like 'Sunnyside%' or e.name is null)
and (e.name not like 'FAKE%' or e.name is null)
group by e.id, e.name, d.id, d.name, dist.school_count

--------------------------------------------------------------

select e.id, e.name, d.id, d.name, dist.school_count, count(distinct s.id), max(sr.submitted_at)
from survey_responses sr 
join organizations s on s.id = sr.organization_id
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
group by e.id, e.name, d.id, d.name, dist.school_count

------------------------------


select d.id, d.name, dist.school_count, count(distinct s.id), max(sr.submitted_at)
from survey_responses sr 
join organizations s on s.id = sr.organization_id
right outer join relationships r on r.child_id = s.id
right outer join organizations d on d.id = r.parent_id
right outer join districts dist on dist.id = d.entity_id
where d.entity_type like 'District'
and d.enabled = 't'
and d.name not like 'Sample%'
and (d.id not in (select r.child_id from relationships r) or d.id not in (select r2.child_id from
 relationships r2 join organizations o2 on o2.id = r2.parent_id where o2.enabled = 't' and o2.entity_type like 'Esa'))
group by d.id, d.name, dist.school_count
order by d.name

-------------------------

select s.id, s.name, max(sr.submitted_at)
from survey_responses sr 
join organizations s on s.id = sr.organization_id
left outer join relationships r on r.child_id = s.id
where (s.id not in (select r.child_id from relationships r))
and s.entity_type like 'School'
group by s.id, s.name

----------

select s.id, s.name, max(sr.submitted_at)
from survey_responses sr 
join organizations s on s.id = sr.organization_id
left outer join relationships r on r.child_id = s.id
left outer join organizations e on e.id = r.parent_id
where (s.id not in (select r.child_id from relationships r join organizations o2 on o2.id = r.parent_id where o2.entity_type like 'District'))
and s.entity_type like 'School'
and e.entity_type like 'Esa'
group by s.id, s.name