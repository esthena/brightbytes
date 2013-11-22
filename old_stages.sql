--stage 3
select k.esa_id, k.esa_name, k.dist_id, k.dist_name, min(max)
from (select e.id as esa_id, e.name as esa_name, d.id as dist_id, d.name as dist_name, s.name, (max(Cast((uos.created_at is not null)as integer))) as max --s.name, uos.created_at, uos.step
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
where d.enabled
group by 1,2,3,4,5) as k
group by 1,2,3,4