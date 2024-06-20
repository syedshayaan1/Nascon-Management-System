create database proj
use proj

create table Category(
categoryId varchar(15) primary key,
categoryName varchar(15),
mentorId varchar(15),
secretaryId varchar(15)
);
create table Events(
eventId  varchar(15) primary key,
eventName varchar(15),
eventDate date,
eventVenue varchar(15),
eventTime time,
eventPrice numeric
);

create table Participant
(
  par_name varchar (15), par_email varchar(15), par_cnic varchar (15), par_contact varchar(15)
   
   PRIMARY KEY (par_cnic)

);

/* ======================= */

create table ParticipantTeam
(
   teamname varchar(15), ins_name varchar(15),
   amb_id varchar(15), teamleadcnic varchar(15)

   PRIMARY KEY (teamname)

);

/* ========================*/

create table ParticipantTeamedInto(
teamname  varchar(15) foreign key references ParticipantTeam(teamname),
participantKey  varchar(15) foreign key references Participant(par_cnic),
primary key(teamname, participantKey)
);


create table foodreg
(
   price varchar (15),
   menu varchar(30)
   primary key(price)
);

create table regforfood
(
  participantkey  varchar(15) foreign key references Participant(par_cnic),
  pricekey varchar(15) foreign key references foodreg(price)
  primary key(participantKey, pricekey)
);
create table eventpartbyteam
(
eventKey  varchar(15) foreign key references Events(eventId),
teamkey varchar(15) foreign key references ParticipantTeam(teamname),
primary key(eventKey, teamkey)
);

create table FacultyMentor(
mentorId  varchar(15) primary key,
mentorName  varchar(15)
);
create table StudentExecutive(
studentId varchar(15) primary Key,
studentName  varchar(15),
batch numeric,
position  varchar(15)
);
create table Sponsor(
sponsorId  varchar(15) primary key,
companyName  varchar(15),
representativeName  varchar(15),
repCNIC numeric(13)
);
create table Administration(
adminId  varchar(15) primary key,
adminUserName  varchar(15)
);

create table CategoryIncludes(
categoryKey  varchar(15) foreign key references Category(categoryId),
eventKey  varchar(15) foreign key references Events(eventId),
primary key(categoryKey, eventKey)
);
create table CategorySuperviseByStudent(
categoryKey  varchar(15) foreign key references Category(categoryId),
studentKey  varchar(15) foreign key references StudentExecutive(studentId),
primary key(categoryKey, studentKey)
);
create table EventSuperviseByStudent(
eventKey  varchar(15) foreign key references Events(eventId),
studentKey  varchar(15) foreign key references StudentExecutive(studentId),
primary key(eventKey, studentKey)
);
create table EventParticipatedBy(
eventKey  varchar(15) foreign key references Events(eventId),
participantKey  varchar(15) foreign key references Participant(par_cnic),
primary key(eventKey, participantKey)
);


create table CategorySuperviseByFaculty(
categoryKey  varchar(15) foreign key references Category(categoryId),
mentorKey  varchar(15) foreign key references FacultyMentor(mentorId),
primary key(categoryKey, mentorKey)
);
create table EventSuperviseByFaculty(
eventKey  varchar(15) foreign key references Events(eventId),
mentorKey  varchar(15) foreign key references FacultyMentor(mentorId),
primary key(eventKey, mentorKey)
);
create table SponsoredBy(
categoryKey  varchar(15) foreign key references Category(categoryId),
sponsorKey  varchar(15) foreign key references Sponsor(sponsorId),
sponsor_type varchar (15),
amount numeric, 
primary key (categoryKey, sponsorKey)
);

select * from events


------------------------------------------------------------------------------------------------
/*

select * from SponsoredBy

--QUERY 2 FOR REPORT-------------------

select sum(amount) as TotalAmount, categoryName from SponsoredBy s, Category c where s.categoryKey=c.categoryId 
group by categoryName

--QUERY 3 FOR REPORT------------------------

select categoryName, eventId, eventName,eventDate,eventVenue,eventTime,eventPrice 
from Category, Events, CategoryIncludes c
where eventId = c.eventKey and c.categoryKey=(select categoryKey from CategorySuperviseByFaculty where mentorKey=5)
--------------------------------------------------------------------------------
--------QUERY 5A  List of all Student Executives (by event, by category, by management department)
select studentId,studentName,batch, position from StudentExecutive s, EventSuperviseByStudent es, CategoryIncludes c, events e
where s.studentId=es.studentKey and c.eventKey=e.eventId 
and c.categoryKey=(select categoryKey from CategorySuperviseByFaculty where mentorKey=5);

----- Query 5B List of all Student Executives (by event, by category, by management department)
select studentId,studentName,batch, position from StudentExecutive s, CategorySuperviseByStudent cs, CategoryIncludes c, events e
where s.studentId=cs.studentKey and c.eventKey=e.eventId 
and c.categoryKey=(select categoryKey from CategorySuperviseByFaculty where mentorKey=5);
------------------------------------------------------------

-----Query Search specific participant by name or unique ID
select par_name, par_email, par_cnic, par_contact from Participant p, EventParticipatedBy ep, CategoryIncludes c, events e 
where p.par_cnic=ep.participantKey and ep.eventKey=c.eventKey and c.eventKey=e.eventId
and c.categoryKey=(select categoryKey from CategorySuperviseByFaculty where mentorKey=5) and par_name = 'NATALIA';

------------------------------------------------------------------
--Query: List of events to be held on specific date

select eventName from events e, CategoryIncludes c where c.eventKey=e.eventId and
c.categoryKey=(select categoryKey from CategorySuperviseByFaculty where mentorKey=5) 
and e.eventDate='2020-02-12';

select *from events
--------------------------------------------------
--Query: List of all the registered participants and their information

select * from Participant p, EventParticipatedBy ep, CategoryIncludes c, events e 
where p.par_cnic=ep.participantKey and ep.eventKey=c.eventKey and c.eventKey=e.eventId
and c.categoryKey=(select categoryKey from CategorySuperviseByFaculty where mentorKey=5);

-----------------------------------------------------------------

-----Query 10 Total number of registrations in a specific event.

select count(participantKey) as TotalParticipants from EventParticipatedBy where eventKey=(select eventid from events where eventName='Coding');

---------------------------------------------

-----Query 11


select * from CategorySuperviseByFaculty
select * from categoryIncludes
select * from EventSuperviseByStudent
select * from CategorySuperviseByStudent
select * from StudentExecutive
select * from EventParticipatedBy
 




select *from CategorySuperviseByFaculty
select * from StudentExecutive
select * from CategorySuperviseByStudent
--drop table SponsoredBy

insert into Administration values('1','ahmed');
insert into FacultyMentor values('2','Sheheryar');
insert into FacultyMentor values('3','Farquleet');
insert into Events values ('2','Coding','2020-03-12','Marriot','14:30:00','2000');
insert into EventSuperviseByFaculty values ('2','3');
insert into Participant values('NATALIA','123@gmail.com','12345','030551'); 
insert into EventParticipatedBy values ('2','12345');

select * from Category
select * from Events
select * from EventSuperviseByStudent
select * from CategorySuperviseByStudent
select * from FacultyMentor
select * from StudentExecutive
select * from sponsor
select * from SponsoredBy

delete EventSuperviseByStudent where studentKey=1;
delete CategorySuperviseByStudent where studentkey=1;
delete StudentExecutive where studentId=1


select * from EventSuperviseByFaculty
select * from EventParticipatedBy
select * from CategoryIncludes
select * from FacultyMentor
select * from CategorySuperviseByFaculty
select * from EventSuperviseByStudent
select * from CategoryIncludes

insert into FacultyMentor values('5','Fahad');
insert into CategorySuperviseByFaculty values ('1','5')

insert into CategorySuperviseByStudent values ('1','1')

insert into StudentExecutive values ('1','Ibrahim','2020','Sir')
insert into EventSuperviseByStudent values ('1','1')


insert CategoryIncludes values('1','1')
insert CategoryIncludes values('1','2')

--select  eventId, eventName,eventDate,eventVenue,eventTime,eventPrice from events,CategoryIncludes where 
select * from CategoryIncludes 
--select * from participants where 

--Faculty mentor of category can view all event details and registrations of events under that category.
select categoryName, eventId, eventName,eventDate,eventVenue,eventTime,eventPrice from Category, Events, CategoryIncludes c, CategorySuperviseByFaculty f 
where eventId=c.eventKey and categoryId=c.categoryKey and f.categoryKey=categoryId and f.mentorKey=5

--Faculty Mentor can also view the details of student executives in their respective category.
--select * from StudentExecutive, EventSuperviseByStudent c, CategorySuperviseByStudent cf
--where c.studentKey=studentId and cf.studentKey=studentId and cf.categoryKey=(select cf.categoryKey from CategorySuperviseByFaculty cf  where cf.mentorKey='5')


select studentId, studentName, batch, position from StudentExecutive, EventSuperviseByStudent c, CategoryIncludes ci
where c.studentKey=studentId and ci.eventKey=c.eventKey and ci.categoryKey=(select cf.categoryKey from CategorySuperviseByFaculty cf  where cf.mentorKey='5')

select studentId, studentName, batch, position from StudentExecutive, EventSuperviseByStudent c, CategorySuperviseByStudent cf
where c.studentKey=studentId and cf.studentKey=studentId and cf.categoryKey=(select cf.categoryKey from CategorySuperviseByFaculty cf  where cf.mentorKey='5')



--insert into 

insert into Category values ('1','CS');
insert into Events values ('1','Programming','2020-02-12','Serena','12:30:00','1500');
insert into CategorySuperviseByFaculty values ('1','2');
insert into EventSuperviseByFaculty values ('1','2');

select eventName from events, CategoryIncludes c where eventId=c.eventKey and c.categoryKey = (select categoryKey from CategorySuperviseByFaculty c where c.mentorKey=5)





select par_name from Participant p, regforfood r, EventParticipatedBy e, CategorySuperviseByFaculty cf
where p.par_cnic=r.participantkey and e.participantKey=p.par_cnic and e.participantKey=r.participantkey and 
cf.mentorKey=5


select * from Participant
select * from EventParticipatedBy


-----------------------------------------------
select * from foodreg

select * from regforfood

drop table regforfood

drop table foodreg
drop table ParticipantTeamedInto
drop table EventParticipatedBy
drop table Participant
drop table ParticipantTeam
drop table EventParticipatedby

select * from participant
select * from eventpartbyteam

------LAST QUERY
select mentorName as FacultyMentor, eventId, eventName,eventDate,eventVenue,eventTime,eventPrice  
from FacultyMentor f, EventSuperviseByFaculty ef, events e 
where f.mentorId=ef.mentorKey and e.eventId=ef.eventKey and ef.eventKey=(select eventId from events where eventName='Coding')

select studentName as EventHead, eventId, eventName,eventDate,eventVenue,eventTime,eventPrice 
from StudentExecutive s, EventSuperviseByStudent es, events e 
where s.studentId=es.studentKey and e.eventId=es.eventKey and es.eventKey=(select eventId from events where eventname='Coding') and position='Event Head'




*/