/*
CREATE LOGIN NandaSurendra

WITH PASSWORD = 'MI$T353Instructor';

CREATE USER NandaSurendra

FOR LOGIN NandaSurendra;



ALTER ROLE db_owner ADD MEMBER NandaSurendra;


*/


if object_id('Team', 'U') is not null
    drop table Team;
if object_id('Game', 'U') is not null
    drop table Game;
if object_id('Stadium', 'U') is not null
    drop table Stadium;



create table Stadium(
    StadiumID int not null identity(1,1),
    StadiumName varchar(100) not NULL,
    StadiumCapacity int NOT NULL,
    StadiumStreetAddress varchar(100) not NULL,
    StadiumCity varchar(100) not NULL,
    StadiumState varchar(100) NULL,
    TypeofField varchar(100) not NULL,
    constraint PK_Stadium primary key (StadiumID),
    constraint UQ_StadiumName unique (StadiumName, StadiumCity, StadiumState),
    constraint CK_TypeofField check (TypeofField in ('Grass', 'Turf', 'Artificial'))
);

    go


create TABLE Team (
    TeamID int not null identity(1,1),
    UniversityName varchar(100) not NULL,
    TeamName varchar(100) not NULL,
    constraint PK_Team primary key (TeamID),
    constraint UQ_UniversityName unique (UniversityName),
    constraint FK_Team_Stadium foreign key (StadiumID) references Stadium(StadiumID),
    

);


go 


CREATE TABLE Game (
    GameID int not null identity(1,1),
    GameDate date not NULL,
    GameTime time not NULL,
    HomeScore int NULL,
    AwayScore int NULL,
    HomeTeamID int not NULL,
    AwayTeamID int not NULL,
    WinnerTeamID int NULL,
    StadiumID int not NULL,
    constraint PK_Game primary key (GameID),
    constraint UQ_Game unique (HomeTeamID, GameDate, GameTime),
    constraint FK_Game_HomeTeam foreign key (HomeTeamID) references Team(TeamID),
    constraint FK_Game_AwayTeam foreign key (AwayTeamID) references Team(TeamID),
    constraint FK_Game_WinnerTeam foreign key (WinnerTeamID) references Team(TeamID),
    constraint FK_Game_Stadium foreign key (StadiumID) references Stadium(StadiumID)
);
