SELECT * FROM schools limit 1; --get the first school
--SELECT [columns you want] FROM [tables you're using] 
--	WHERE [certain conditions are met] ORDER BY [sequence you want]
--	this is for getting individual data elements - another type aggregates data elements
SELECT name FROM schools WHERE state = 'PA' ORDER BY name LIMIT 5;
--first five schools from pennsylvania ordered by alphabet

SELECT * FROM organizations WHERE entity_type != 'State' LIMIT 5;

--aggregation; GROUP BY [rollup category]

SELECT entity_type, state, COUNT(*) as cnt FROM organizations GROUP BY 1, 2 ORDER BY 3 desc;

SELECT id, name, city, state FROM schools WHERE state like 'VT' AND city like 'Middlebury'

SELECT * from schools WHERE id = 94028

SELECT o.id, o.name, count(*) from organizations o, surveys s where o.state='IA' and o.id = s.organization_id GROUP BY 1 ORDER BY 3 desc;

SELECT o.id, o.name, count(*) from organizations o, surveys s where o.state='IA' and o.id = s.organization_id GROUP BY 1 ORDER BY 3 desc, 2;


