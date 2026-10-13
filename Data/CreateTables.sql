/*
CREATE LOGIN NandaSurendra

WITH PASSWORD = 'MI$T353Instructor';

CREATE USER NandaSurendra

FOR LOGIN NandaSurendra;



ALTER ROLE db_owner ADD MEMBER NandaSurendra;


*/
if object_id('Position') is not null
    drop table Position;
if object_id('Coach') is not null
    drop table Coach;
if object_id('GamePrediction') is not null
    drop table GamePrediction;
if object_id('QBStats') is not null
    drop table QBStats;
if object_id('WeeklyPredictionResults') is not null
    drop table WeeklyPredictionResults;
if object_id('PlayerStats') is not null
    drop table PlayerStats;
if object_id('Player') is not null
    drop table Player;
if object_id('Roster') is not null
    drop table Roster;


if object_id('RBStats') is not null
    drop table RBStats;
if object_id('DefenderStats') is not null
    drop table DefenderStats;
if object_id('ReturnerStats') is not null
    drop table ReturnerStats;
if object_id('KickerStats') is not null
    drop table KickerStats;
if object_id('PunterStats') is not null
    drop table PunterStats;

if object_id('Game') is not null
    drop table Game;
if object_id('AppUserTeam') is not null
    drop table AppUserTeam;
if object_id('Team') is not null
    drop table Team;

if object_id('Stadium') is not null
    drop table Stadium;

if object_id('AppUser') is not null
    drop table AppUser;





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
    stadiumID int not NULL,
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

go 

create table AppUser(
    AppUserID int not null identity(1,1),
    FirstName varchar(100) not NULL,
    LastName varchar(100) not NULL,
    Email varchar(100) not NULL,
    UserPassword varchar(100) not NULL,
    constraint PK_AppUser primary key (AppUserID),
    constraint UQ_AppUser_Email unique (Email)
);

go


create table AppUserTeam(
    AppUserID int not NULL,
    TeamID int not NULL,
    constraint PK_AppUserTeam primary key (AppUserID, TeamID),
    constraint FK_AppUserTeam_AppUser foreign key (AppUserID) references AppUser(AppUserID),
    constraint FK_AppUserTeam_Team foreign key (TeamID) references Team(TeamID)
);

go


create table GamePrediction(
    
    GamePredictionID int not null identity(1,1),
    PredictionDateTime datetime not NULL default getdate(),
    GameID int not NULL,
    AppUserID int not NULL,
    TeamID int not NULL,
    constraint PK_GamePrediction primary key (GamePredictionID),
    constraint FK_GamePrediction_Game foreign key (GameID) references Game(GameID),
    constraint FK_GamePrediction_AppUser foreign key (AppUserID) references AppUser(AppUserID),
    constraint FK_GamePrediction_PredictedWinnerTeam foreign key (TeamID) references Team(TeamID)
);


create table WeeklyPredictionResults(
    WeeklyPredictionResultsID int not null identity(1,1),
    startDate date not NULL default getdate(),
    numberOfCorrectPredictions int not NULL default 0,
    appUserID int not NULL,
    constraint PK_WeeklyPredictionResults primary key (WeeklyPredictionResultsID),
    constraint FK_WeeklyPredictionResults_AppUser foreign key (appUserID) references AppUser(AppUserID)
);

go

 create table Player (
    PlayerID int not null identity(1,1),
    PlayerName varchar(100) not NULL,
    PlayerDateOfBirth date not NULL,
    constraint PK_Player primary key (PlayerID)
);

go
 

 create table Position(
    
    PositionID int not null identity(1,1),
    PositionName varchar(100) not NULL,
    constraint PK_Position primary key (PositionID),
    constraint UQ_PositionName unique (PositionName)
 )
 
 go

 create table Roster (
    RosterID int not null identity(1,1),
    Year int not NULL,
    SeasonWins int not NULL,
    SeasonLosses int not NULL,
    SeasonTies int not NULL,
    TeamID int not NULL,
    constraint PK_Roster primary key (RosterID),

    constraint FK_Roster_Team foreign key (TeamID) references Team(TeamID)
 )


go


create table PlayerStats(
    PlayerStatsID int not null identity(1,1),
    Position varchar(100) not NULL,
    constraint PK_PlayerStats primary key (PlayerStatsID),
    constraint Fk_PlayerStats_Roster foreign key (PlayerStatsID) references Roster(RosterID),
    constraint Fk_PlayerStats_Player foreign key (PlayerStatsID) references Player(PlayerID),
    constraint UQ_PlayerStats_Position unique (Position)


)

go


create table Coach(
    CoachID int not null identity(1,1),
    CoachName varchar(100) not NULL,
    constraint PK_Coach primary key (CoachID)
)



go


create table QBStats(
    QBStatsID int not null identity(1,1),
    Attempts int not NULL,
    Completions int not NULL,
    Yards int not NULL,
    TDs int not NULL,
    INTs int not NULL,
    constraint PK_QBStats primary key (QBStatsID),
    constraint FK_QBStats_PlayerStats foreign key (QBStatsID) references PlayerStats(PlayerStatsID)

)

go

create table RBStats(
    RBStatsID int not null identity(1,1),
    Carries int not NULL,
    Yards int not NULL,
    TDs int not NULL,
    Long int not NULL,
    Fumbles int not NULL,
    constraint PK_RBStats primary key (RBStatsID)
)

go

create table DefenderStats(
    DefenderStatsID int not null identity(1,1),
    Tackles int not NULL,
    Sacks int not NULL,
    Interceptions int not NULL,
    DefensiveTDs int not NULL,
    constraint PK_DefenderStats primary key (DefenderStatsID)
)


go

create table ReturnerStats(
    ReturnerStatsID int not null identity(1,1),
    KickoffAttempts int not NULL,
    KickoffYards int not NULL,
    KickoffLong int not NULL,
    KickoffTDs int not NULL,
    PuntReturnsAttemps int not NULL,
    PuntReturnYards int not NULL,
    PuntReturnLong int not NULL,
    PuntReturnTDs int not NULL,
    constraint PK_ReturnerStats primary key (ReturnerStatsID)
)

go

create table KickerStats(
    KickerStatsID int not null identity(1,1),
    FieldGoalsAttempted int not NULL,
    FieldGoalsMade int not NULL,
    ExtraPointsAttempted int not NULL,
    ExtraPointsMade int not NULL,
    Long int not NULL,
    constraint PK_KickerStats primary key (KickerStatsID)
)

go

create table PunterStats(
    PunterStatsID int not null identity(1,1),
    Punts int not NULL,
    PuntYards int not NULL,
    PuntLong int not NULL,
    constraint PK_PunterStats primary key (PunterStatsID)
)

go