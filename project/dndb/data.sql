insert into employees values(1,'Nathanael','Dick','nwd3@students.calvin.edu');
insert into employees values(2,'Daniel','Dick','dd35@students.calvin.edu');
insert into employees values(3,'Paul','Dick','paulllldick@gmail.com');
insert into employees values(4,'Joseph','Dick','JoejoeJosephTimdick@gmail.com');
insert into employees values(5,'Vangel','Víkingr','nwd3@students.calvin.edu');
insert into employees values(6,'Izidor','Asher','dd35@students.calvin.edu');
insert into employees values(7,'Rufino','Goronwy','paulllldick@gmail.com');
insert into employees values(8,'António','Kepheus','JoejoeJosephTimdick@gmail.com');
insert into employees values(9,'Glen', 'Xander','nwd3@students.calvin.edu');
insert into employees values(10,'Alfred', 'Lal','dd35@students.calvin.edu');
insert into employees values(11,'Eyvindr', 'Mateo','paulllldick@gmail.com');
insert into employees values(12,'Pantaleone', 'Afonso','JoejoeJosephTimdick@gmail.com');

insert into part values(1,11,'funline_pen','gun_metal_pen',2.25);
insert into part values(2,11,'funline_pen','chrome_pen',2.25);
insert into part values(3,11,'funline_pen','24kt_gold_pen',2.25);
insert into part values(4,11,'funline_pen','copper',2.25);
insert into part values(5,222,'funline_pen','gun_metal_pen',2.25);
insert into part values(6,12,'funline_pen','chrome_pen',2.25);
insert into part values(7,2,'funline_pen','24kt_gold_pen',2.25);
insert into part values(8,3,'funline_pen','copper',2.25);
insert into part values(9,11,'funline_pen','satin pearl',2.25);
insert into part values(10,11,'funline_pen','special chrome',2.25);
insert into part values(11,56,'funline_pen','extra gold',2.25);
insert into part values(12,1,'funline_pen','steel_finish',2.25);
insert into part values(13,4,'funline_pen','brass',2.25);
insert into part values(14,3,'funline_pen','ivory',2.25);
insert into part values(15,45,'funline_pen','titanium',2.25);
insert into part values(16,2,'funline_pen','gold',2.25);

-- I plan to add a lot more customer values from our etsy store as time allows but these allowed me to test the database
insert into customer values(1,'Paul','Hendry','paulhendry20@googlemail.com','Paul Hendry
31 The Moorings, Prince Regent Lane
London, E16 3JN
United Kingdom');

insert into customer values(2,'Gary','Peat','garyrpeat@outlook.com','Gary Peat
12 Newstead Close
Eye
Peterborough, PE6 7UH
United Kingdom');
insert into customer values(3,'Victoria','Johnson','dreammer.of.dreams@gmail.com','Victoria Johnson
168 Vernon Ave
Yonkers, NY 10704-2486
United States');

insert into orders values(0,'26-FEB-2017','03-MAR-2017','',4,1,1,1);
insert into orders values(1,'26-FEB-2017','03-MAR-2017','',4,1,1,1);
insert into orders values(2,'26-FEB-2017','03-MAR-2017','',4,1,1,1);
insert into orders values(3,'26-FEB-2017','03-MAR-2017','',4,1,1,1);
insert into orders values(4,'26-FEB-2017','03-MAR-2017','',4,1,1,1);
insert into orders values(5,'26-FEB-2017','03-MAR-2017','',4,1,1,1);
insert into orders values(6,'26-FEB-2017','03-MAR-2017','',4,1,1,1);
insert into orders values(7,'26-FEB-2017','03-MAR-2017','',4,1,1,1);
insert into orders values(8,'26-FEB-2017','03-MAR-2017','',4,1,1,1);
insert into orders values(9,'26-FEB-2017','03-MAR-2017','',4,1,1,1);
insert into orders values(10,'26-FEB-2017','03-MAR-2017','',4,1,1,1);

insert into partorder values(1,0,4);
insert into partorder values(2,0,2);
insert into partorder values(2,1,1);
insert into partorder values(3,1,3);
insert into partorder values(2,2,1);
insert into partorder values(1,2,9);

insert into reviews values(1,0,'Nice Product');
insert into reviews values(2,1,'Nice Product');
insert into reviews values(3,3,'Nice Product');

insert into Feedback values(0,0,2,'Try to make then product differently');
insert into Feedback values(1,1,3,'Try to make then product differently');
insert into Feedback values(2,2,1,'Try to make then product differently');