--level-appropriate users


select o.id, o.name, u.first_name, u.last_name
from organizations o
join visibilities v on v.organization_id = o.id
join users u on u.id = v.user_id
where u.id not in (select u_par.id
from users u_chi
join visibilities v2 on v2.user_id = u_chi.id
join organizations o2 on o2.id = v2.organization_id
join relationships r2 on r2.child_id = o2.id
join visibilities v_par on v_par.organization_id = r2.parent_id
join users u_par on v_par.user_id = u_par.id
where o2.id = o.id)


--direct/shared user count
select o.id, o.name, count(*)
from organizations o
join visibilities v on v.organization_id = o.id
join users u on u.id = v.user_id
where u.id not in (select u_par.id
from users u_chi
join visibilities v2 on v2.user_id = u_chi.id
join organizations o2 on o2.id = v2.organization_id
join relationships r2 on r2.child_id = o2.id
join visibilities v_par on v_par.organization_id = r2.parent_id
join users u_par on v_par.user_id = u_par.id
where o2.id = o.id)
group by o.id, o.name
order by 3 desc