--How many stops are in the database. 

SELECT COUNT(*)
FROM stops;

--Find the id value for the stop 'Craiglockhart' 

SELECT id
FROM stops
WHERE name = 'Craiglockhart';

--Give the id and the name for the stops on the '4' 'LRT' service. 

SELECT id, name
FROM stops
JOIN route
ON stops.id = route.stop
WHERE route.num = '4' AND route.company = 'LRT';

--Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes. 

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2;

--. Change the query so that it shows the services from Craiglockhart to London Road. 

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = (SELECT id FROM stops WHERE name = 'London Road');

--Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road';

--Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith') 

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
a.company = b.company AND a.num = b.num
WHERE a.stop = 115 AND b.stop = 137;

--Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross' 

SELECT a.company, a.num
FROM route a JOIN route b 
ON a.company = b.company AND a.num = b.num
JOIN stops stopa ON a.stop = stopa.id
JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross';

--Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart'
-- itself, offered by the LRT company. Include the company and bus no. of the relevant services. 

SELECT DISTINCT stopb.name, a.company, a.num
FROM route a JOIN route b
ON a.company = b.company AND a.num = b.num
JOIN stops stopa ON stopa.id = a.stop
JOIN stops stopb ON stopb.id = b.stop
WHERE stopa.name = 'Craiglockhart' AND a.company = 'LRT';

