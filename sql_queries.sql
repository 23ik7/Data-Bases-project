-- QUERY 1
SELECT w.name, e.weingut 
FROM Erzeuger AS e, Wein AS w
WHERE e.weingut = w.weingut
AND e.region = 'Bordeaux';

-- QUERY 2
SELECT count(farbe) as Anzahl
FROM Wein
WHERE farbe = 'Rot';

-- QUERY 3
SELECT count(farbe) as Anzahl, farbe
FROM Wein
GROUP BY farbe;

-- QUERY 4
SELECT weingut
FROM gutachter AS ga
GROUP BY weingut
HAVING count(weingut) > 1;
	
-- QUERY 5
SELECT w.name, w.jahrgang
FROM Wein as w, 
(
	select min(jahrgang) as m_jahr from wein
) AS mj
WHERE w.jahrgang = mj.m_jahr;

-- QUERY 6	
SELECT g.name, g.vorname
FROM Gutachter AS g
EXCEPT
SELECT ga.name, ga.vorname
FROM Gutachter AS ga, Gutachten AS gt
WHERE ga.gid = gt.gid;

-- QUERY 7
SELECT gt.wid, gt.gid, gt.punkte 
FROM Gutachten AS gt, Gutachter AS ga, Wein AS w
WHERE gt.wid = w.wid AND gt.gid = ga.gid
	
EXCEPT
	
SELECT gt.wid, gt.gid, gt.punkte
FROM Gutachten AS gt, Gutachter AS ga, Wein AS w
WHERE gt.wid = w.wid AND gt.gid = ga.gid AND w.weingut = ga.weingut
ORDER BY wid ASC;

-- QUERY 8
SELECT w.wid, ga.gid, ga.punkte, avg
FROM (
	
SELECT wid, avg(punkte) AS avg
FROM Gutachten
GROUP BY wid

) AS w , Gutachten AS ga
WHERE w.wid = ga.wid AND abs(ga.punkte - avg) > 2
GROUP BY w.wid, ga.gid, ga.punkte, avg;

-- QUERY 9
SELECT name, vorname, titel
FROM Gutachter
ORDER BY LENGTH(titel) DESC
LIMIT 1;

-- QUERY 10
SELECT ha.wid, w.name, s.anteil
FROM
(
	
SELECT wid, sum(anteil) AS anteil
FROM hergestellt_aus
GROUP BY wid
	
) AS s, Hergestellt_aus AS ha, Wein AS w
WHERE ha.wid = s.wid AND w.wid = ha.wid AND s.anteil <> 100
GROUP BY ha.wid, w.name, s.anteil;