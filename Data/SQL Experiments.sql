select * from PlayerStats;

select * from Roster;
select * from Player;
select * from Conference;
select * from Team;
go

insert into Conference(ConferenceName) values ('Big 12');

insert into Team(UniversityName, TeamName, StadiumID) values ('West Virginia University', 'Mountaineers', 1);

insert into Player(PlayerName, PlayerDateOfBirth) values ('John Doe', '1990-01-01');



insert into Roster(Year, SeasonWins, SeasonLosses, SeasonTies, TeamID) values (2023, 10, 2, 0, 1);