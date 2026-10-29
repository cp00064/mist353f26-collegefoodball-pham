select SYSDATETIMEOFFSET() at time zone 'US Eastern Standard Time' as EasternTime;
select * from PlayerStats;

select * from Roster;
select * from Player;
select * from Conference;
select * from Team;
go

insert into Conference(ConferenceName) values ('Big 12');

insert into Stadium(StadiumName, StadiumCapacity, StadiumStreetAddress, StadiumCity, StadiumState, TypeofField) values ('Mountaineer Field at Milan Puskar Stadium', 60000, '1 Mountaineer Field Drive', 'Morgantown', 'WV', 'Grass');

insert into Team(UniversityName, TeamName, conferenceID) values ('West Virginia University', 'Mountaineers', 1);

insert into Player(PlayerName, PlayerDateOfBirth) values ('John Doe', '1990-01-01');



insert into Roster(Year, SeasonWins, SeasonLosses, SeasonTies, TeamID) values (2023, 10, 2, 0, 1);