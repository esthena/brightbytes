
select snd.school_id, s.name, nd.nces_id, nd.name
from school_nces_data snd
join schools s on s.id = snd.school_id
join nces_data nd on nd.id = snd.nces_datum_id