--stage 2
select d.id, d.name, e.id, e.name
from organizations d
left join relationships r on r.parent_id = d.id
left join organizations s on r.child_id = s.id
join relationships r2 on r2.child_id = d.id
join organizations e on e.id = r2.parent_id and e.enabled
left join visibilities v on v.organization_id = d.id and v.inferred = 'f'
left join users u on u.id = v.user_id and
	u.id not in 
	(select usr.id
	from users usr
	join visibilities vis on vis.user_id = usr.id
	join organizations org on org.id = v.organization_id
	where org.entity_type like 'Esa')
where d.id not in (select dist.id
	from organizations dist
	join relationships rel on rel.parent_id = dist.id
	and rel.child_id in(select qr.organization_id from questionnaire_responses qr
	union all select sr.organization_id from survey_responses sr)
	)
and d.entity_type like 'District'
group by d.id, d.name, e.id, e.name
order by e.name, d.name
--stage 3
select k.esa_id, k.esa_name, k.dist_id, k.ent_type, k.dist_name
from (select e.id as esa_id, e.name as esa_name, d.entity_type as ent_type, d.id as dist_id, d.name as dist_name, s.name, (max(Cast((uos.created_at is not null)as integer))) as max --s.name, uos.created_at, uos.step
from organizations d
join relationships r on r.parent_id = d.id
join organizations s on s.id = r.child_id and s.entity_type like 'School' and s.enabled
left join visibilities v on v.organization_id = s.id and v.inferred = 'f'
left join users u on u.id = v.user_id 
	and u.id not in (select usr.id
	from users usr
	join visibilities vis on vis.user_id = usr.id
	join organizations org on org.id = v.organization_id
	where org.entity_type like 'Esa' or org.entity_type like 'District')
left join user_onboarding_steps uos on uos.user_id = u.id and uos.step like 'clicked_onboarding_link'
left join relationships r2 on r2.child_id = d.id 
left join organizations e on e.id = r2.parent_id and e.entity_type like 'Esa'
group by 1,2,3,4,5,6
order by 4) as k
group by 1,2,3,4,5
having min(max) = 0
and max(max) = 1
--stage 4
select d.entity_type, d.id, d.name
from organizations d
join relationships r on r.parent_id = d.id
join organizations s on r.child_id = s.id and s.enabled
join schools sch on sch.id = s.entity_id and s.entity_type like 'School'
left join school_nces_data snd on snd.school_id = sch.id
left join nces_data nd on snd.nces_datum_id = nd.id
where d.enabled
and d.id not in (119800, 148697, 19906,20141,20225,119796,119798,119799,119801,119803,119804,119805,119806,119807,119808,119810,20170,20343,119795,119776,119778,119772,119779,119774,119773,119780,119781,119783,119784,119785,119786,119788,119790,119791,119792,119794,119769,119770,19837)
group by d.id, d.name
having min(Cast(nd.approved as integer)) < 1
--stage 5
select d.entity_type, d.id, d.name, min(q.start_date), current_date, current_date - min(q.start_date)
from organizations d
join relationships r on r.parent_id = d.id
join organizations s on r.child_id = s.id and s.enabled
join schools sch on sch.id = s.entity_id and s.entity_type like 'School'
left join school_nces_data snd on snd.school_id = sch.id
left join nces_data nd on snd.nces_datum_id = nd.id
left join questionnaires q on q.organization_id = s.id
where d.enabled
and d.id not in (119800, 148697, 19906,20141,20225,119796,119798,119799,119801,119803,119804,119805,119806,119807,119808,119810,20170,20343,119795,119776,119778,119772,119779,119774,119773,119780,119781,119783,119784,119785,119786,119788,119790,119791,119792,119794,119769,119770,19837)
group by d.id, d.name
having min(Cast(nd.approved as integer)) = 1
and (current_date - min(q.start_date)>0 or min(q.start_date) is null)
--stage 6
select d.entity_type, d.id, d.name, max(q.end_date)
from organizations d
join relationships r on r.parent_id = d.id
join organizations s on s.id = r.child_id and s.entity_type like 'School'
join questionnaires q on q.organization_id = s.id
join questionnaire_responses qr on qr.organization_id = s.id
where d.id not in (119800, 148697, 19906,20141,20225,119796,119798,119799,119801,119803,119804,119805,119806,119807,119808,119810,20170,20343,119795,119776,119778,119772,119779,119774,119773,119780,119781,119783,119784,119785,119786,119788,119790,119791,119792,119794,119769,119770,19837)
and s.id not in (119800, 148697, 19906,20141,20225,119796,119798,119799,119801,119803,119804,119805,119806,119807,119808,119810,20170,20343,119795,119776,119778,119772,119779,119774,119773,119780,119781,119783,119784,119785,119786,119788,119790,119791,119792,119794,119769,119770,19837)
group by 1,2,3
having max(q.end_date)-current_date > 0
--stage 7
select d.entity_type, d.id, d.name, max(q.end_date)
from organizations d
join relationships r on r.parent_id = d.id
join organizations s on s.id = r.child_id and s.entity_type like 'School'
join questionnaires q on q.organization_id = s.id
join questionnaire_responses qr on qr.organization_id = s.id
where d.id not in (119800, 148697, 19906,20141,20225,119796,119798,119799,119801,119803,119804,119805,119806,119807,119808,119810,20170,20343,119795,119776,119778,119772,119779,119774,119773,119780,119781,119783,119784,119785,119786,119788,119790,119791,119792,119794,119769,119770,19837)
and s.id not in (119800, 148697, 19906,20141,20225,119796,119798,119799,119801,119803,119804,119805,119806,119807,119808,119810,20170,20343,119795,119776,119778,119772,119779,119774,119773,119780,119781,119783,119784,119785,119786,119788,119790,119791,119792,119794,119769,119770,19837)
group by 1,2,3
having max(q.end_date) is null
