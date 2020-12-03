--UC1 --> Create database AddressBook_Service
create database Address_Book_Service;

use Address_Book_Service;

--UC2 --> Ability to create a Address Book Table with first and last names, address, city, state, zip, phone number and email as its attributes

create table Address_Book
(
	First_Name varchar(20),
	Last_Name varchar(20),
	Address varchar(20),
	City varchar(15),
	State varchar(15),
	Zip int,
	Phone_Number varchar(13),
	Email varchar(20)
);

--UC3 --> Ability to insert new Contacts to Address Book
Insert into Address_Book(First_Name,Last_Name,Address,City,State,Zip,Phone_Number,Email) values
('Abhishek','J','Vijaynagar','Mysore','Karnataka',590016,'8951604950','abhij@gmail.com'),
('Bhavana','Ram','Indiranagar','Belgaum','Mumbai',548965,'9984189632','bhavana@gmail.com'),
('Chandan','Jay','Rajajinagar','Hubli','Madhyapradesh',571258,'7412365895','jay@gmail.com'),
('Darmesh','Reddy','Chordroad','Hyderabad','Andhrapradesh',589647,'7547891235','reddy@yahoo.com')

Select * from Address_Book

--UC4 -->Ability to edit existing contact person using their name
update Address_Book set Last_Name='Kunal' where First_Name='Darmesh';

Select * from Address_Book

--UC5 -->Ability to delete a person using person's name
Delete from Address_Book where First_Name = 'Darmesh';

--UC6 --> Ability to Retrieve Person belonging to a City or State from the Address Book
Select * from Address_Book;

--UC7 --> Ability to understand the size of address book by City and State
Select COUNT(City) as City_Count from Address_Book ;
Select COUNT(State) as State_Count from Address_Book ;

--UC8 --> Ability to retrieve entries sorted alphabetically by Person’s name 
Select * from Address_Book order by First_Name Asc;

--UC9 --> Ability to identify each Address Book with name and Type. - Here the type could Family, Friends, Profession, etc
--- Alter Address Book to add name and type

Alter table  Address_Book add AddressBook_Name varchar(20) , Type varchar(20);

Update Address_Book set Type = 'Family' , AddressBook_Name = 'A' where First_Name='Abhishek';
Update Address_Book set Type = 'Friend', AddressBook_Name = 'B' where Last_Name='Ram';
Update Address_Book set Type='Profession' , AddressBook_Name = 'C' where Last_Name='Jay';

select * from Address_Book

--UC10 --> Ability to get number of contact persons i.e. count by type
Select COUNT(Type) as Family_Members from Address_Book where Type = 'Family' group by Type;

Select Count(Type) as Friend from Address_Book where Type = 'Friend' group by Type;

--UC12 --> Ability to create Normalization table for Address_Book

/*----------------------CREATE NEW ADDRESS BOOK-------------------------*/
create table New_Address_Book
(
	Id int primary key identity(1,1),
	First_Name varchar(50),
	Last_Name varchar(50),
	Address varchar(50),
	City varchar(50),
	State varchar(50),
	Zip int,
	Phone_Number varchar(50),
	Email varchar(50)
);

Insert into New_Address_Book values
('Prerana','Singh','CollegeRoad','Belgaum','Karnataka',590016,'8792981111','prerana@gmail.com'),
('Rani','Weeber','Srinagar','Hubli','Karnataka',589632,'7412589632','rani@gmail.com'),
('Vicky','Kaushal','Ameerpet','Hyderabad','AndhraPradesh',456987,'8523697412','vivek@gmail.com'),
('Saayesha','Tubaki','Basweshwar Nagar','Bangalore','Karnataka',560079,'6987452315','saayesha@gmail.com')

select * from New_Address_Book

create table Address_Book_Name
(
	Id int,
	Name varchar(30),
	Foreign Key (Id) references New_Address_Book(Id)
);

select * from Address_Book_Name;

create table Address_Book_Type
(
	Id int,
	Type varchar(50),
	Foreign Key (Id) references New_Address_book(Id),
);

Select * from Address_Book_Type

Insert into Address_Book_Type values(1,'Friend'),(2,'Family'),(3,'Profession'),(4,'Friend');

/*UC6 --> Retireve the person belong to a particular city or state*/

select * from New_Address_Book where city = 'Belgaum';

select * from New_Address_Book where state = 'Andhra Pradesh'

/*UC 7 --> A bility to get the count of address book by state or city*/
Select Count(state) as State_Count from New_Address_Book where state = 'Karnataka' group by state 

Select Count(city) as City_Count from New_Address_Book where city = 'Bangalore' group by city 

/*UC8 --> To sort alphabetically*/
Select * from New_Address_Book order by First_Name

/*UC10 -->  Ability to get the number of contact persons by type*/
Select Count(Type) , Type
from Address_Book_Name ad_name  , Address_Book_Type ad_type
where ad_name.Id = ad_type.Id
group by Type;

/*UC18 - Date added column is created is inserted*/

Alter table New_Address_Book 
Add AddedDate DateTime

select * from New_Address_Book

Update New_Address_Book Set AddedDate = '01-01-2019' where Id = 1;
Update New_Address_Book Set AddedDate = '02-12-2019' where Id = 2;
Update New_Address_Book Set AddedDate = '03-09-2018' where Id = 3;
Update New_Address_Book Set AddedDate = '12-04-2020' where Id = 4;

select * from New_Address_Book

update New_Address_Book Set First_Name = 'Surabhi' where Id = 4;

select * from New_Address_Book
