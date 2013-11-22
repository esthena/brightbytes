
select d.id, d.name, d.districtid from versions v
join districts d on d.id = v.item_id and v.item_type like 'District'
where v.object_changes like '%districtid%'
order by v.created_at desc