-- not all enabled schools are approved
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

--- all enabled schools are approved:
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
having min(Cast(nd.approved as integer)) = 1


---- all enabled schools are approved but haven't started data collection
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
and (current_date - min(q.start_date)<0 or min(q.start_date) is null)