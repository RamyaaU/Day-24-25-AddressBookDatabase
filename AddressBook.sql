--UC 1 : Ability to create Address Book Service DB 
--Creating new database
create database addressbook_service;

use addressbook_service;

--UC2--
--creating table addressbook
create table addressbook
(FirstName varchar(100) not null,
LastName varchar(100),
Address_Details varchar(500) not null,
City varchar(50) not null,
State_Name varchar(50) not null,
Zip int not null,
PhoneNo bigint not null,
Email varchar(250) not null
);

--UC3--
--Insert data into table
insert into addressbook (FirstName,LastName,Address_Details,City,State_Name,Zip,PhoneNo,Email)
values
('Steve','Rogers','Times_Square','Lucknow','UP',233221,9988778899,'steve@gmail.com'),
('Tony','Stark','Block_2','Surat','Gujrat',2233225,5544554433,'tony.stark@yahoo.com'),
('Captain','America','NIT_Agartala','Agartala','Tripura',799046,9988776655,'captain.america@gmail.com'),
('Thanos','Uncle','sector_2','Kota','Rajasthan',655443,998775654,'thanos@avengers.com'),
('Robert','Downey','Stark_Tower','Kolkata','West_Bengal',8877665,9988776677,'robert@gmail.com');

-- displaying table
select * from addressbook;

--UC4--
--dataretrieval--
select * from addressbook;

--UC 5 : Ability to delete existing contact person using their name 
--Edit and Update data of an existing contact
delete from addressbook  where FirstName='Steve' and LastName='Rogers';

-- displaying table
select * from addressbook;

--UC 6 : Ability to retrieve person belonging to a city or state from address book table
--Retrieve details of people belonging to either city Surat or state Tripura
select * from addressbook where State_Name='Tripura' or City='Surat';

--UC 7 : Ability to understand the size of address book by City and State
--Inserting more data into table
insert into addressbook values
('Peter','Parker','Sector 32','Surat','Gujrat',137667,7765434567,'peter@gmail.com'),
('Virat','Kohli','Block 2','Varodra','Gujrat',138675,9876545678,'virat@gmail.com');
select * from addressbook;
--Find size of address book by city
select City,count(City) as PeopleInCity from addressbook group by City;
--Find size of address book by State
select State_Name,count(State_Name) as PeopleInState from addressbook group by State_Name;

  
--UC 8 : Ability to retrieve entries sorted alphabetically by Person’s name for a given city
--Displaying table
select * from addressbook;
--Retrieve entries sorted alphabetically by name for Surat
select * from addressbook where City='Surat' order by FirstName+LastName;

--UC 9 : Ability to identify each Address Book with name and Type
--Altering address_book to add new columns, addressbookName and Type of contacts
alter table addressbook add AddressBookName varchar(100),ContactType varchar(100);
--Updating the new columns
update addressbook set AddressBookName='Akash';
update addressbook set ContactType='FRIENDS' where State_Name='Gujrat';
update addressbook set ContactType='FAMILY' where State_Name='Tripura';
update addressbook set ContactType='PROFESSION' where State_Name='Rajasthan';

--Find the details with given address book name and given contact type
select * from addressbook where AddressBookNAme='Akash' and ContactType='FRIENDS';

--UC10--: Ability to get number of contact persons i.e. count by type

--Getting number of contact persons for each ContactType
select ContactType,Count(ContactType) as NumberOfContacts from addressbook group by ContactType;

--UC 11 : Ability to add person to both Friend and Family
--Adding the same person to both friend and family types
insert into addressbook values
('Tony','Stark','Block_2','Surat','Gujrat',2233225,5544554433,'tony.stark@yahoo.com','Akash','FAMILY');
--Retrieving details of the duplicated contact
select * from addressbook where FirstName='Tony' and LastName='Stark';

--uc12
create table contact(
ID int not null identity(1,1) primary key,
FirstName varchar(20) not null,
LastName varchar(20) not null,
PhoneNo varchar(20) not null,
Email varchar(30) not null);

select * from contact;
insert into contact values (
'Peter','Parker','7765434567','peter@gmail.com');
insert into contact values (
'Tony','Stark','5544554433','tony.stark@yahoo.com');
insert into contact values (
'Virat','Kohli','9876545678','virat@gmail.com');
insert into contact values (
'Robert','Downey','9988776677','robert@gmail.com');

create table address(
ID int not null foreign key references contact(ID),
AddressBookName varchar(20) not null,
ContactType varchar(20) not null,
Address_Details varchar(100),
City varchar(100),
State_Name varchar(100),
Zip varchar(6)
);

select * from address;

insert into address values(
1,'Peter','FRIENDS','Newtown','Kolkata','WB','786598');
insert into address values(
2,'Tony','PROFESSION','NIT','Agartala','Tripura','799260');
insert into address values(
3,'Captain','FRIENDS','Mansarovar','moradabad','UP','233221');
insert into address values(
4,'Robert','FAMILY','Mayur Vihar','Delhi','Delhi','233223');

update address set ID=4 where AddressBookName='Peter';

/*UC 13 : Ensuring all retrieve queries are working fine with new table structure*/
select * from contact;
select * from contact_address;
select * from type;
select * from contact_type;
select * from addressbookList;
select * from addressbookmap;

--UC 6 working
--persons in aparticular city
select c.*,ca.city,ca.state,ca.zip
from contact c,contact_address ca
where c.Firstname=ca.FirstName and c.LastName=ca.lastName and ca.city='delhi';
--persons in a particular state
select c.*,ca.city,ca.state,ca.zip
from contact c,contact_address ca
where c.Firstname=ca.FirstName and c.LastName=ca.lastName and ca.state='chennai';

--UC 7 working
select City,count(City) as PeopleInCity from contact_address group by City;
select State,count(State) as PeopleInState from contact_address group by State;

--UC 8 working
select c.*,ca.city,ca.state,ca.zip
from contact c,contact_address ca
where c.Firstname=ca.FirstName and c.LastName=ca.lastName and ca.City='delhi' 
order by ca.FirstName,ca.LastName;

--UC 10 working
select t.ContactType,count(ct.TypeCode) as NumberOfContacts
from contact_type ct,type t
where t.TypeCode=ct.TypeCode
group by t.ContactType;
