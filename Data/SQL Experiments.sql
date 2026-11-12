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
ALTER TABLE Player ALTER COLUMN PlayerDateOfBirth date NULL;
SELECT fk.name AS TenKhoa,
       OBJECT_NAME(fk.parent_object_id) AS BangChua,
       COL_NAME(fc.parent_object_id, fc.parent_column_id) AS Cot,
       OBJECT_NAME(fk.referenced_object_id) AS TroToiBang,
       COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS TroToiCot
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fc ON fk.object_id = fc.constraint_object_id
WHERE fk.name = 'Fk_PlayerStats_Player';

ALTER TABLE PlayerStats DROP CONSTRAINT Fk_PlayerStats_Player;

ALTER TABLE PlayerStats ADD CONSTRAINT FK_PlayerStats_Player
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID);

ALTER TABLE PlayerStats DROP CONSTRAINT Fk_PlayerStats_Roster;
ALTER TABLE PlayerStats DROP CONSTRAINT Fk_PlayerStats_Player;
ALTER TABLE PlayerStats DROP CONSTRAINT UQ_PlayerStats_Roster;

ALTER TABLE PlayerStats ADD CONSTRAINT Fk_PlayerStats_Roster
    FOREIGN KEY (RosterID) REFERENCES Roster(RosterID);
ALTER TABLE PlayerStats ADD CONSTRAINT Fk_PlayerStats_Player
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID);
ALTER TABLE PlayerStats ADD CONSTRAINT UQ_PlayerStats_Roster
    UNIQUE (PlayerID, RosterID);