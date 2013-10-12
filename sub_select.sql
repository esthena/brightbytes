--schools, all tabs
select b.school_enabled, b.school_id, b.school_name, max(Cast(b.esa_enabled as integer)), max(b.esa_state), max(b.esa_id), max(b.esa_name), max(Cast(b.dist_enabled as integer)), max(b.dist_id), max(b.dist_name), max(b.school_count)
 from
(select e.enabled as esa_enabled, e.state as esa_state, e.id as esa_id, e.name as esa_name, d.enabled as dist_enabled, d.id as dist_id, d.name as dist_name, dist.school_count as school_count, s.enabled as school_enabled, s.id as school_id, s.name as school_name, max(Cast(q.active as integer))
from organizations s
left join questionnaires q on q.organization_id = s.id and q.active = 't'
left join relationships r on r.child_id = s.id
left join organizations d on d.id = r.parent_id and d.entity_type like 'District'
left join districts dist on dist.id = d.entity_id
left join relationships r2 on r2.child_id = s.id
left join organizations e on e.id = r2.parent_id and e.enabled = 't' and e.entity_type like 'Esa' and e.name not like 'Sunnyside%' and e.name not like 'FAKE%' and e.name not like 'Sample%'
where e.enabled or d.enabled or s.enabled
and s.entity_type like 'School'
group by e.enabled, e.state, e.id, e.name, d.enabled, d.id, d.name, dist.school_count, s.enabled, s.id, s.name, dist.school_count
order by e.name, d.name) as b
group by b.school_enabled, b.school_id, b.school_name


--------
--- schools w/ active, all tabs


select b.school_enabled, b.school_id, b.school_name, max(Cast(b.esa_enabled as integer)), max(b.esa_state), max(b.esa_id), max(b.esa_name), max(Cast(b.dist_enabled as integer)), max(b.dist_id), max(b.dist_name), max(b.school_count), max(b.active)
 from
(select e.enabled as esa_enabled, e.state as esa_state, e.id as esa_id, e.name as esa_name, d.enabled as dist_enabled, d.id as dist_id, d.name as dist_name, dist.school_count as school_count, s.enabled as school_enabled, s.id as school_id, s.name as school_name, max(Cast(q.active as integer)) as active
from organizations s
left join questionnaires q on q.organization_id = s.id and q.active = 't'
left join relationships r on r.child_id = s.id
left join organizations d on d.id = r.parent_id and d.entity_type like 'District'
left join districts dist on dist.id = d.entity_id
left join relationships r2 on r2.child_id = s.id
left join organizations e on e.id = r2.parent_id and e.enabled = 't' and e.entity_type like 'Esa' and e.name not like 'Sunnyside%' and e.name not like 'FAKE%' and e.name not like 'Sample%'
where e.enabled or d.enabled or s.enabled
and s.entity_type like 'School'
group by e.enabled, e.state, e.id, e.name, d.enabled, d.id, d.name, dist.school_count, s.enabled, s.id, s.name, dist.school_count
order by e.name, d.name) as b
group by b.school_enabled, b.school_id, b.school_name


---------
-- schools with data
select s.enabled, s.id, s.name, max(pre_aug_sr.submitted_at), greatest(max(post_aug_sr.submitted_at), max(qr.submitted_at))
from organizations s
left join survey_responses pre_aug_sr on pre_aug_sr.organization_id = s.id and pre_aug_sr.submitted_at < '2013-08-01'
left join survey_responses post_aug_sr on post_aug_sr.organization_id = s.id and post_aug_sr.submitted_at > '2013-08-01'
left join questionnaire_responses qr on  qr.organization_id = s.id and qr.submitted_at < '2013-10-09'
where s.enabled = 't'
group by 1,2,3
------
---hopefully - latest data collection before aug1, latest dat collection after aug 1
---

select b.school_enabled, b.school_id, b.school_name, max(Cast(b.esa_enabled as integer)), max(b.esa_state), max(b.esa_id), max(b.esa_name), max(Cast(b.dist_enabled as integer)), max(b.dist_id), max(b.dist_name), max(b.school_count), max(b.active), max(b.pre_a), max(b.post_a)
 from
(select e.enabled as esa_enabled, e.state as esa_state, e.id as esa_id, e.name as esa_name, d.enabled as dist_enabled, d.id as dist_id, d.name as dist_name, dist.school_count as school_count, s.enabled as school_enabled, s.id as school_id, s.name as school_name, max(Cast(q.active as integer)) as active, max(pre_aug_sr.submitted_at) as pre_a, greatest(max(post_aug_sr.submitted_at), max(qr.submitted_at)) as post_a
from organizations s
left join questionnaires q on q.organization_id = s.id and q.active = 't'
left join survey_responses pre_aug_sr on pre_aug_sr.organization_id = s.id and pre_aug_sr.submitted_at < '2013-08-01'
left join survey_responses post_aug_sr on post_aug_sr.organization_id = s.id and post_aug_sr.submitted_at > '2013-08-01'
left join questionnaire_responses qr on  qr.organization_id = s.id and qr.submitted_at < '2013-10-09'
left join relationships r on r.child_id = s.id
left join organizations d on d.id = r.parent_id and d.entity_type like 'District'
left join districts dist on dist.id = d.entity_id
left join relationships r2 on r2.child_id = s.id
left join organizations e on e.id = r2.parent_id and e.enabled = 't' and e.entity_type like 'Esa' and e.name not like 'Sunnyside%' and e.name not like 'FAKE%' and e.name not like 'Sample%'
where e.enabled or d.enabled or s.enabled
and s.entity_type like 'School'
group by e.enabled, e.state, e.id, e.name, d.enabled, d.id, d.name, dist.school_count, s.enabled, s.id, s.name, dist.school_count
order by e.name, d.name) as b
group by b.school_enabled, b.school_id, b.school_name
----------

--usable - problems with active in table 1 of union
(select s.enabled as school_enabled, s.id as school_id, s.name as school_name, Cast(e.enabled as integer) as esa_enabled, e.state as esa_state, e.id as esa_id, e.name as esa_name, Cast(d.enabled as integer) as dist_enabled, d.id as dist_id, d.name as dist_name, dist.school_count as school_count, 2 as active, max(pre_aug_sr.submitted_at) as pre_a, greatest(max(post_aug_sr.submitted_at), max(qr.submitted_at)) as post_a
from organizations s
left join survey_responses pre_aug_sr on pre_aug_sr.organization_id = s.id and pre_aug_sr.submitted_at < '2013-08-01'
left join survey_responses post_aug_sr on post_aug_sr.organization_id = s.id and post_aug_sr.submitted_at > '2013-08-01'
left join questionnaire_responses qr on  qr.organization_id = s.id and qr.submitted_at < '2013-10-09'
left join relationships r on r.child_id = s.id
left join organizations d on d.id = r.parent_id and d.entity_type like 'District'
left join relationships rtwo on rtwo.child_id = s.id 
left join organizations e on rtwo.parent_id = e.id and e.entity_type like 'Esa'
left join districts dist on dist.id = d.entity_id
where s.enabled = 't'
and s.id not in (119800,
19906,
20141,
20225,
119796,
119798,
119799,
119801,
119803,
119804,
119805,
119806,
119807,
119808,
119810,
20170,
20343,
119795,
119776,
119778,
119772,
119779,
119774,
119773,
119780,
119781,
119783,
119784,
119785,
119786,
119788,
119790,
119791,
119792,
119794,
119769,
119770,
19837)
group by 1,2,3,4,5,6,7,8,9,10,11
UNION ALL
select b.school_enabled, b.school_id, b.school_name, max(Cast(b.esa_enabled as integer)) as esa_enabled, max(b.esa_state) as esa_state, max(b.esa_id) as esa_id, max(b.esa_name) as esa_name, max(Cast(b.dist_enabled as integer)) as dist_enabled, max(b.dist_id) as dist_id, max(b.dist_name) as dist_name, max(b.school_count) as school_count, max(b.active) as active, '1900-01-01' as pre_a,  '1900-01-01' as post_a
 from
(select e.enabled as esa_enabled, e.state as esa_state, e.id as esa_id, e.name as esa_name, d.enabled as dist_enabled, d.id as dist_id, d.name as dist_name, dist.school_count as school_count, s.enabled as school_enabled, s.id as school_id, s.name as school_name, max(Cast(q.active as integer)) as active
from organizations s
left join questionnaires q on q.organization_id = s.id and q.active = 't'
left join relationships r on r.child_id = s.id
left join organizations d on d.id = r.parent_id and d.entity_type like 'District'
left join districts dist on dist.id = d.entity_id
left join relationships r2 on r2.child_id = s.id
left join organizations e on e.id = r2.parent_id and e.enabled = 't' and e.entity_type like 'Esa' and e.name not like 'Sunnyside%' and e.name not like 'FAKE%' and e.name not like 'Sample%'
where (e.enabled or d.enabled)
and not(s.enabled)
and s.entity_type like 'School'
and s.id not in (119800,
19906,
20141,
20225,
119796,
119798,
119799,
119801,
119803,
119804,
119805,
119806,
119807,
119808,
119810,
20170,
20343,
119795,
119776,
119778,
119772,
119779,
119774,
119773,
119780,
119781,
119783,
119784,
119785,
119786,
119788,
119790,
119791,
119792,
119794,
119769,
119770,
19837)
group by e.enabled, e.state, e.id, e.name, d.enabled, d.id, d.name, dist.school_count, s.enabled, s.id, s.name, dist.school_count
order by e.name, d.name) as b
group by b.school_enabled, b.school_id, b.school_name)
order by esa_name, dist_name

-------
--active works:
(select s.enabled as school_enabled, s.id as school_id, s.name as school_name, Cast(e.enabled as integer) as esa_enabled, e.state as esa_state, e.id as esa_id, e.name as esa_name, Cast(d.enabled as integer) as dist_enabled, d.id as dist_id, d.name as dist_name, dist.school_count as school_count, max(Cast(q.active as integer)) as active, max(pre_aug_sr.submitted_at) as pre_a, greatest(max(post_aug_sr.submitted_at), max(qr.submitted_at)) as post_a
from organizations s
left join questionnaires q on q.organization_id = s.id and q.active = 't'
left join survey_responses pre_aug_sr on pre_aug_sr.organization_id = s.id and pre_aug_sr.submitted_at < '2013-08-01'
left join survey_responses post_aug_sr on post_aug_sr.organization_id = s.id and post_aug_sr.submitted_at > '2013-08-01'
left join questionnaire_responses qr on  qr.organization_id = s.id and qr.submitted_at < '2013-10-09'
left join relationships r on r.child_id = s.id
left join organizations d on d.id = r.parent_id and d.entity_type like 'District'
left join relationships rtwo on rtwo.child_id = s.id 
left join organizations e on rtwo.parent_id = e.id and e.entity_type like 'Esa'
left join districts dist on dist.id = d.entity_id
where s.enabled = 't'
and s.id not in (119800,
19906,
20141,
20225,
119796,
119798,
119799,
119801,
119803,
119804,
119805,
119806,
119807,
119808,
119810,
20170,
20343,
119795,
119776,
119778,
119772,
119779,
119774,
119773,
119780,
119781,
119783,
119784,
119785,
119786,
119788,
119790,
119791,
119792,
119794,
119769,
119770,
19837)
group by 1,2,3,4,5,6,7,8,9,10,11
UNION ALL
select b.school_enabled, b.school_id, b.school_name, max(Cast(b.esa_enabled as integer)) as esa_enabled, max(b.esa_state) as esa_state, max(b.esa_id) as esa_id, max(b.esa_name) as esa_name, max(Cast(b.dist_enabled as integer)) as dist_enabled, max(b.dist_id) as dist_id, max(b.dist_name) as dist_name, max(b.school_count) as school_count, max(b.active) as active, '1900-01-01' as pre_a,  '1900-01-01' as post_a
 from
(select e.enabled as esa_enabled, e.state as esa_state, e.id as esa_id, e.name as esa_name, d.enabled as dist_enabled, d.id as dist_id, d.name as dist_name, dist.school_count as school_count, s.enabled as school_enabled, s.id as school_id, s.name as school_name, max(Cast(q.active as integer)) as active
from organizations s
left join questionnaires q on q.organization_id = s.id and q.active = 't'
left join relationships r on r.child_id = s.id
left join organizations d on d.id = r.parent_id and d.entity_type like 'District'
left join districts dist on dist.id = d.entity_id
left join relationships r2 on r2.child_id = s.id
left join organizations e on e.id = r2.parent_id and e.enabled = 't' and e.entity_type like 'Esa' and e.name not like 'Sunnyside%' and e.name not like 'FAKE%' and e.name not like 'Sample%'
where (e.enabled or d.enabled)
and not(s.enabled)
and s.entity_type like 'School'
and s.id not in (119800,
19906,
20141,
20225,
119796,
119798,
119799,
119801,
119803,
119804,
119805,
119806,
119807,
119808,
119810,
20170,
20343,
119795,
119776,
119778,
119772,
119779,
119774,
119773,
119780,
119781,
119783,
119784,
119785,
119786,
119788,
119790,
119791,
119792,
119794,
119769,
119770,
19837)
group by e.enabled, e.state, e.id, e.name, d.enabled, d.id, d.name, dist.school_count, s.enabled, s.id, s.name, dist.school_count
order by e.name, d.name) as b
group by b.school_enabled, b.school_id, b.school_name)
order by esa_name, dist_name




