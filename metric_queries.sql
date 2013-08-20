-- esas and districts where districts have a school that has at least one survey response
select e.name, o.name
from organizations o
join relationships r on o.id = r.parent_id
join organizations s on s.id = r.child_id
join relationships rtwo on rtwo.child_id = o.id
join organizations e on e.id = rtwo.parent_id
right join survey_responses sr on sr.organization_id = s.id
where e.entity_type like 'Esa'
and o.entity_type like 'District'
and o.name not like 'Sunnyside%' 
and e.name not like 'Sunnyside%'
and o.name not like 'FAKE%'
and e.name not like 'FAKE%'
and o.name not like 'Sample%'
and e.name not like 'Sample%'
group by e.name, o.name
order by e.name;


--esas and schools where schools have at least one survey response
-- 'Esa' can also be 'District'
select o.name, s.name
from organizations o
join relationships r on o.id = r.parent_id
join organizations s on s.id = r.child_id
right join survey_responses sr on sr.organization_id = s.id
where o.entity_type like 'Esa'
and s.entity_type like 'School'
and o.name not like 'Sunnyside%' 
and o.name not like 'FAKE%'
and o.name not like 'Sample%'
group by o.name, s.name
order by o.name;


--esas and district counts 
-- could be 'Esa' and 'School'
--could be 'District' and 'School'
select o.name,count(*)
from organizations o
join relationships r on o.id = r.parent_id
join organizations s on s.id = r.child_id
where o.entity_type like 'Esa'
and s.entity_type like 'District'
and o.name not like 'Sunnyside%' 
and o.name not like 'FAKE%'
and o.name not like 'Sample%'
group by o.name
order by o.name;