/* Anshul Vyas */


/*Basic SQL  Exercise (1-10) */ 

===================================================================================================

/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */


 Ans:1 	SELECT name
			FROM Facilities
			WHERE membercost > 0
			
			
			
	Output : name
			Tennis Court 1
			Tennis Court 2
			Massage Room 1
			Massage Room 2
			Squash Court		
			
=======================================================================================


/* Q2: How many facilities do not charge a fee to members? */

 Ans:2 	SELECT count(name) as Total_Free_Facilities
			FROM Facilities
			WHERE membercost = 0
			
			
			
	Output :    Total_Free_Facilities
                4 	
			


=======================================================================================

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

 Ans:3 	FROM Facilities
			WHERE membercost < ( (monthlymaintenance *20) / ( 100 ) )
			
	Output :    	facid	name				membercost	monthlymaintenance	
					0		Tennis Court 1			5.0			200
					1		Tennis Court 2			5.0			200
					2	    Badminton Court			0.0			50
					3		Table Tennis			0.0			10
					4		Massage Room 1			9.9			3000
					5		Massage Room 2			9.9			3000
					6		Squash Court			3.5			80
					7		Snooker Table			0.0			15
					8		Pool Table				0.0			15
			



=======================================================================================

/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */



 Ans:4 	(select * from Facilities where facid = 1)

			UNION

			(select * from Facilities where facid = 5)

			
	Output :    	
					
			
				facid	name	membercost	guestcost	initialoutlay	monthlymaintenance	
				1	  Tennis Court 2	5.0	25.0	8000	200
				5	  Massage Room 2	9.9	80.0	4000	3000





=========================================================================================


/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

 Ans:5 	    SELECT name, monthlymaintenance,
				CASE WHEN monthlymaintenance <=100 THEN 'cheap'
				ELSE 'expensive' END AS catagory
				FROM Facilities

			
	Output :    	
				
				name	      monthlymaintenance	catagory	
				Tennis Court 2	200					expensive
				Tennis Court 1	200					expensive
				Table Tennis	10					cheap
				Squash Court	80					cheap
				Snooker Table	15					cheap
				Pool Table		15					cheap
				Massage Room 2	3000				expensive
				Massage Room 1	3000				expensive
				Badminton Court	50

=========================================================================================

/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

 Ans : 6 
					SELECT firstname, surname ,joindate 
					FROM `Members` 
					order by joindate desc 
					limit 1

Output :           
					firstname	surname	joindate	
					Darren	Smith	2012-09-26 18:08:45



=========================================================================================

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

 Ans : 7   

					
						SELECT DISTINCT CONCAT( firstname, '  ', surname ) AS fullname,
						CASE WHEN facid =0
						THEN 'Tennis Court 1 '
						ELSE 'Tennis Court 2'
						END AS Court_Name
						FROM Members A
						JOIN Bookings B ON A.memid = B.memid
						WHERE facid =0
						OR facid =1
						ORDER BY firstname			
					
					
	Output :      		fullname	      Court_Name	
						Anne  Baker	    Tennis Court 2
						Anne  Baker	    Tennis Court 1
						Burton  Tracy	Tennis Court 1
						Burton  Tracy	Tennis Court 2
						Charles  Owen	Tennis Court 2
						Charles  Owen	Tennis Court 1
						Darren  Smith	Tennis Court 2
						David  Farrell	Tennis Court 1
						David  Pinker	Tennis Court 1
						David  Jones	Tennis Court 1
						David  Jones	Tennis Court 2
						David  Farrell	Tennis Court 2
						Douglas  Jones	Tennis Court 1
						Erica  Crumpet	Tennis Court 1
						Florence  Bader	Tennis Court 1
						Florence  Bader	Tennis Court 2
						Gerald  Butters	Tennis Court 2
						Gerald  Butters	Tennis Court 1
						GUEST  GUEST	Tennis Court 1
						GUEST  GUEST	Tennis Court 2
						Henrietta  Rumney	Tennis Court 2
						Jack  Smith	Tennis Court 1
						Jack  Smith	Tennis Court 2
						Janice  Joplette	Tennis Court 2
						Janice  Joplette	Tennis Court 1
						Jemima  Farrell	Tennis Court 1
						Jemima  Farrell	Tennis Court 2
						Joan  Coplin	Tennis Court 1
						John  Hunt	Tennis Court 2
						John  Hunt	Tennis Court 1
						Matthew  Genting	Tennis Court 1
						Millicent  Purview	Tennis Court 2
						Nancy  Dare	Tennis Court 1
						Nancy  Dare	Tennis Court 2
						Ponder  Stibbons	Tennis Court 1
						Ponder  Stibbons	Tennis Court 2
						Ramnaresh  Sarwin	Tennis Court 1
						Ramnaresh  Sarwin	Tennis Court 2
						Tim  Boothe	Tennis Court 1
						Tim  Rownam	Tennis Court 1
						Tim  Rownam	Tennis Court 2
						Tim  Boothe	Tennis Court 2
						Timothy  Baker	Tennis Court 2
						Timothy  Baker	Tennis Court 1
						Tracy  Smith	Tennis Court 2
						Tracy  Smith	Tennis Court 1
				
======================================================================================


/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */



Ans : 8 	select  B.bookid, F.name as Facility_name, 
					    case when M.surname != 'GUEST' THEN concat(M.firstname, ' ' , M.surname) else 'GUEST' END as Full_Name,
					    case WHEN B.memid = 0 THEN B.slots * F.guestcost
							ELSE B.slots * F.membercost END as Cost
					    from Bookings B 
							join Members M on B.memid = M.memid 
							join Facilities F on B.facid = F.facid
						AND
						starttime like '%2012-09-14%'
				        where 
				              (case WHEN B.memid = 0 THEN B.slots * F.guestcost 
							        ELSE B.slots * F.membercost END ) >30

						order by Cost desc




Output : 

						bookid	Facility_name	Full_Name	    Cost	
						2946	Massage Room 2	GUEST	  	    320.0
						2940	Massage Room 1	GUEST			160.0
						2942	Massage Room 1	GUEST			160.0
						2937	Massage Room 1	GUEST			160.0
						2926	Tennis Court 2	GUEST			150.0
						2920	Tennis Court 1	GUEST			75.0
						2925	Tennis Court 2	GUEST			75.0
						2922	Tennis Court 1	GUEST			75.0
						2948	Squash Court	GUEST			70.0
						2941	Massage Room 1	Jemima Farrell	39.6
						2949	Squash Court	GUEST			35.0
						2951	Squash Court	GUEST			35.0

=========================================================================================

/* Q9: This time, produce the same result as in Q8, but using a subquery. */



Ans:9  Select Z.Bookid, 
              Z.Facility_Name, 
			  Z.cost, 
			  concat(M.firstname, ' ' , M.surname) as Full_Name 
	   FROM (select B.memid, 
	                B.bookid, 
					F.name as Facility_name, 
					case when B.memid = 0 then B.slots*F.guestcost 
					     ELSE B.slots*F.membercost END as cost 
			FROM Bookings B 
			join Facilities F 
			ON B.facid = F.facid 
			where starttime like '%2012-09-14%' 
			AND (case when B.memid = 0 then B.slots*F.guestcost else B.slots*F.membercost end) > 30) Z 
			join Members M 
			on Z.memid = M.memid 




Output : 
				Bookid	Facility_Name	cost	Full_Name	
				2920	Tennis Court 1	75.0	GUEST GUEST
				2922	Tennis Court 1	75.0	GUEST GUEST
				2925	Tennis Court 2	75.0	GUEST GUEST
				2926	Tennis Court 2	150.0	GUEST GUEST
				2937	Massage Room 1	160.0	GUEST GUEST
				2940	Massage Room 1	160.0	GUEST GUEST
				2941	Massage Room 1	39.6	Jemima Farrell
				2942	Massage Room 1	160.0	GUEST GUEST
				2946	Massage Room 2	320.0	GUEST GUEST
				2948	Squash Court	70.0	GUEST GUEST
				2949	Squash Court	35.0	GUEST GUEST
				2951	Squash Court





===========================================================================================

/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

Ans : 10  

					select  F.facid,
							F.name as Facility_name, 
							 SUM(case WHEN B.memid = 0 THEN B.slots * F.guestcost
								 ELSE B.slots * F.membercost END) as Revenue
					from Bookings B 
					join Facilities F on B.facid = F.facid 
					group by F.facid, F.name
					having SUM(case WHEN B.memid = 0 THEN B.slots * F.guestcost
								 ELSE B.slots * F.membercost END) < 1000


Output : 
						facid	Facility_name	Revenue	
						3	Table Tennis	180.0
						7	Snooker Table	240.0
						8	Pool Table	270.0




=================================================================================================













