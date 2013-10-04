
select o.entity_type, o.id, o.name, u.first_name, u.last_name, u.email, max(l.logged_in_at)
from users u
join visibilities v on v.user_id = u.id
join organizations o on o.id = v.organization_id
join logins l on l.user_id = u.id
where v.user_id in (select u.id from users u join visibilities v on v.user_id = u.id join logins l on l.user_id = u.id
	where v.organization_id = o.id 
	order by l.logged_in_at desc limit 1)
and o.enabled = 't'
and u.email not like '%brightbytes%'
group by o.entity_type, o.id, o.name, u.first_name, u.last_name, u.email