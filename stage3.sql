-------- stage 2 districts
select d.id, d.name from organizations d 
join relationships r on r.child_id = d.id
join organizations e on e.id = r.parent_id
where d.entity_type like 'District'
and e.entity_type like 'Esa'
and not(d.enabled)
and e.enabled
--------- stage 3 districts
select d.entity_type, d.id, d.name
from organizations d
join relationships r on r.parent_id = d.id
join organizations s on s.id = r.child_id and s.entity_type like 'School'
where s.id not in (select k.id from
((select sr.organization_id as id from survey_responses sr group by sr.organization_id)
union all
(select qr.organization_id as id from questionnaire_responses qr group by qr.organization_id)) as k
group by k.id)
and d.enabled = 't'
and s.id not in
(select o.id
from organizations o
join visibilities v on v.organization_id = o.id
join users u on u.id = v.user_id
join user_onboarding_steps uos on uos.user_id = u.id and uos.step like 'clicked_onboarding_link'
where u.id not in (select u_par.id
from users u_chi
join visibilities v2 on v2.user_id = u_chi.id
join organizations o2 on o2.id = v2.organization_id
join relationships r2 on r2.child_id = o2.id
join visibilities v_par on v_par.organization_id = r2.parent_id
join users u_par on v_par.user_id = u_par.id
where o2.id = o.id)
and o.entity_type like 'School')
and s.enabled
group by d.id, d.name
---------- districts past stage 3
select d.id, d.name
from organizations d
where d.entity_type like 'District'
and d.enabled
and d.id not in(
	select dist.id
	from organizations dist
	join relationships r on r.parent_id = dist.id
	join organizations sch on sch.id = r.child_id and sch.enabled and sch.id not in
		(select o.id
		from organizations o
		join visibilities v on v.organization_id = o.id
		join users u on u.id = v.user_id
		join user_onboarding_steps uos on uos.user_id = u.id and uos.step like 'clicked_onboarding_link'
		where u.id not in (select u_par.id
		from users u_chi
		join visibilities v2 on v2.user_id = u_chi.id
		join organizations o2 on o2.id = v2.organization_id
		join relationships r2 on r2.child_id = o2.id
		join visibilities v_par on v_par.organization_id = r2.parent_id
		join users u_par on v_par.user_id = u_par.id
		where o2.id = o.id)
		and o.entity_type like 'School'
		group by o.id))
-----stage 4
select d.id, d.name
from organizations d
join relationships r2 on r2.parent_id = d.id
join organizations s on s.id = r2.child_id
join schools on schools.id = s.entity_id and s.entity_type like 'School'
join school_nces_data snd on snd.school_id = schools.id
join nces_data nd on snd.nces_datum_id = nd.id and nd.approved = 'f'
where d.entity_type like 'District'
and d.enabled
and d.id not in(
	select dist.id
	from organizations dist
	join relationships r on r.parent_id = dist.id
	join organizations sch on sch.id = r.child_id and sch.enabled and sch.id not in
		(select o.id
		from organizations o
		join visibilities v on v.organization_id = o.id
		join users u on u.id = v.user_id
		join user_onboarding_steps uos on uos.user_id = u.id and uos.step like 'clicked_onboarding_link'
		where u.id not in (select u_par.id
		from users u_chi
		join visibilities v2 on v2.user_id = u_chi.id
		join organizations o2 on o2.id = v2.organization_id
		join relationships r2 on r2.child_id = o2.id
		join visibilities v_par on v_par.organization_id = r2.parent_id
		join users u_par on v_par.user_id = u_par.id
		where o2.id = o.id)
		and o.entity_type like 'School'
		group by o.id))
group by d.id, d.name

---------------schools stage 4
select s.id, s.name
from organizations s
join schools on schools.id = s.entity_id and s.entity_type like 'School'
join school_nces_data snd on snd.school_id = schools.id
join nces_data nd on snd.nces_datum_id = nd.id and nd.approved = 'f'
where s.id not in (select sch.id from organizations sch join relationships r2 on r2.child_id = sch.id and sch.enabled)
and s.enabled
and s.entity_type like 'School'
and s.id not in (select k.id from
((select sr.organization_id as id from survey_responses sr group by sr.organization_id)
union all
(select qr.organization_id as id from questionnaire_responses qr group by qr.organization_id)) as k
group by k.id)
