create table player_database.players(
Player_ID int NOT NULL PRIMARY KEY,
Player_name varchar(40) NOT NULL,
Age int,
Stance varchar(40),
Batting_order varchar(40),
Wicketkeeper varchar(40),
Bowler_Type varchar(40),
Auction_ID int,
Team_Name varchar(40)
);

alter table Player_database.players add FOREIGN KEY (Auction_ID) REFERENCES player_database.auction(Auction_ID); 
alter table Player_database.players add FOREIGN KEY (Team_Name) REFERENCES player_database.team(Team_Name);



select * from players;

create table player_database.batsmen(
Player_ID int NOT NULL PRIMARY KEY,
Player_name varchar(40) NOT NULL,
Age int,
Stance varchar(40),
Batting_order varchar(40),
Wicketkeeper varchar(40),
Bowler_Type varchar(40)
);

select * from batsmen;

create table player_database.bowler(
Player_ID int NOT NULL PRIMARY KEY,
Player_name varchar(40) NOT NULL,
Age int,
Stance varchar(40),
Batting_order varchar(40),
Bowler_Type varchar(40)
);

select * from bowler;

create table player_database.allrounder(
Player_ID int NOT NULL PRIMARY KEY,
Player_name varchar(40) NOT NULL,
Age int,
Stance varchar(40),
Batting_order varchar(40),
Bowler_Type varchar(40)
);

select * from allrounder;

create table player_database.Nationalities(
Player_ID int NOT NULL,
Nationality_type varchar(40)
);

select * from Nationalities;

create table player_database.auction(
Auction_ID int NOT NULL PRIMARY KEY,
Prev_Year_Price int,
Base_Price int
);

select * from auction;

create table player_database.Coach(
Coach_ID int NOT NULL PRIMARY KEY,
Coach_Name varchar(40) NOT NULL,
Coach_type varchar(40),
Team_Name varchar(40),
FOREIGN KEY (Team_Name) REFERENCES player_database.Team(Team_name)
);

INSERT INTO player_database.Coach (Coach_ID, Coach_Name, Coach_type, Team_Name)
VALUES
  (111,'lasith Malinga','Bowling coach','Mumbai Indians'),
  (112, 'Rajiv Kumar', 'Fielding coach', 'Chennai Super Kings'),
  (113, 'Brian Lara', 'Batting coach', 'Sunrisers Hyderabad'),
  (114, 'Brendon McCullum', 'Batting coach', 'Kolkata Knight Riders'),
  (115, 'Adam Griffith', 'Bowling coach', 'Royal Challengers Bangalore'),
  (116, 'Biju George', 'Fielding coach', 'Delhi Capitals'),
  (117, 'Wasim Jaffer', 'Batting coach', 'Punjab Kings'),
  (118, 'Amol Muzumdar', 'Batting coach', 'Rajasthan Royals'),
  (119, 'Dwayne Bravo', 'Bowling coach', 'Chennai Super Kings'),
  (120, 'James Pamment', 'Fielding coach', 'Mumbai Indians'),
  (121, 'Shane Bond', 'Bowling coach', 'Rajasthan Royals'),
  (122, 'Pravin Amre', 'Batting coach', 'Delhi Capitals'),
  (123, 'Dale Steyn', 'Bowling coach', 'Sunrisers Hyderabad'),
  (124, 'Ten Doeschate', 'Fielding coach', 'Kolkata Knight Riders'),
  (125, 'Charl Langeveldt', 'Bowling coach', 'Punjab Kings'),
  (126, 'Adam Griffith', 'Batting coach', 'Royal Challengers Bangalore'),
  (127, 'Kieron Pollard', 'Batting coach', 'Mumbai Indians'),
  (128, 'Micheal Hussey', 'Batting coach', 'Chennai Super Kings'),
  (129, 'Narendra Singh Negi', 'Fielding coach', 'Gujarat Titans'),
  (130, 'James Hopes', 'Bowling coach', 'Delhi Capitals'),
  (131, 'Rohit', 'Fielding coach', 'Lucknow Super Giants'),
  (132, 'Bharat Arun', 'Bowling coach', 'Kolkata Knight Riders'),
  (133, 'Trevor Bayliss', 'Fielding coach', 'Punjab Kings'),
  (134, 'Malolan Rangarajan', 'Fielding coach', 'Royal Challengers Bangalore'),
  (135, 'Aashish Kapoor', 'Bowling coach', 'Gujarat Titans'),
  (136, 'Gary Kirsten', 'Batting coach', 'Gujarat Titans'),
  (137, 'Gautam Gambhir', 'Batting coach', 'Lucknow Super Giants'),
  (138, 'Morne Morkel', 'Bowling coach', 'Lucknow Super Giants'),
  (139, 'Hemang Badani', 'Fielding coach', 'Sunrisers Hyderabad'),
  (140, 'Dishant Yagnik', 'Fielding coach', 'Rajasthan Royals');

  
select * from Coach;


create table player_database.team(
Team_Name varchar(40) NOT NULL PRIMARY KEY,
Owner varchar(40),
Home_city varchar(40),
Home_ground varchar(40)
); 

select * from team;

create table player_database.Matches(
Match_Num int NOT NULL PRIMARY KEY,
Match_date date,
Winning_Team varchar(40),
Losing_Team varchar(40),
Venue varchar(200),
Result varchar(200)
);

select * from matches;



create table player_database.plays(
Team_Name varchar(40) NOT NULL,
Match_Num int NOT NULL,
PRIMARY KEY (Team_Name, Match_Num),
FOREIGN KEY (Team_Name) REFERENCES player_database.Team(Team_name),
FOREIGN KEY (Match_Num) REFERENCES player_database.Matches(Match_Num)
);


select * from plays;

create table player_database.performances(
Performance_ID int NOT NULL PRIMARY KEY,
Run_Scored int,
Balls_Faced int,
No_of_boundaries int,
MOM varchar(40),
Wickets_taken int,
Player_ID int,
Match_Num int,
FOREIGN KEY (Player_ID) REFERENCES player_database.Players(Player_ID),
FOREIGN KEY (Match_Num) REFERENCES player_database.Matches(Match_Num)
);

select * from performances;




select a.Player_ID,a.Player_Name, sum(b.Run_Scored),sum(b.Balls_Faced),sum(b.Run_Scored)/count(b.Match_Num) as Batting_avg, 
sum(b.Wickets_Taken)/count(b.Match_Num) as Bowling_avg, (sum(b.Run_Scored)/sum(b.Balls_Faced))*100 as strike_rate
from Player_database.performances b 
join Player_database.players a
on b.Player_ID = a.Player_ID
group by 1,2
order by 5 desc
;

select a.Player_ID,a.Player_name, sum(Run_Scored), sum(Balls_Faced)
from Player_database.performances b 
left join Player_database.players a
on b.Player_ID = a.Player_ID
where a.Player_name = 'Virat Kohli'
group by 1,2;

select * from performances
where Player_ID = '1189'
;

select a.Player_ID,a.Player_Name, 
sum(b.Wickets_Taken)/count(b.Match_Num) as wicket
from Player_database.performances b 
left join Player_database.players a
on b.Player_ID = a.Player_ID
where Player_Name like '%Shami%'
group by 1,2
order by 3 desc;
 

select a.Player_ID,a.Player_Name,
sum(b.Run_Scored)/count(b.Match_Num) as Batting_avg, 
sum(b.Wickets_Taken)/count(b.Match_Num) as Bowling_avg, 
(sum(b.Run_Scored)/sum(b.Balls_Faced))*100 as strike_rate
from Player_database.performances b 
left join Player_database.players a
on b.Player_ID = a.Player_ID
group by 1,2
having count(match_num) >= 7
order by 5 desc
limit 10;

select * from performances
where player_id = 1229; 


select * from Player_database.performances;

select a.player_id, a.Player_name, sum(b.Run_scored) as Total_runs from performances b
left join players a
on a.player_id = b.player_id
group by 1,2
order by 3 desc
limit 20;


select Player_ID,sum(Wickets_taken) as total_wickets from performances
group by Player_ID
order by total_wickets desc
;

select Nationality_type,count(*) from Nationalities
where Nationality_type = 'Indian'
group by 1;