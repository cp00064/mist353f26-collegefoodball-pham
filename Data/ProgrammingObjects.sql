-- 1. actions for WeeklyPredictionResults 

declare @startDate date;


select U.AppUserID, U.FirstName, U.LastName, U.Email, max (WPR.numberOfCorrectPredictions) 
from WeeklyPredictionResults WPR join AppUser U on WPR.AppUserID = U.AppUserID
where WPR.startDate=@startDate
--where getdate() between WPR.StartDate and dateadd(day, 6, WPR.startDate)
group by U.AppUserID, U.FirstName, U.LastName, U.Email;



-- store procedure
-- SQL + Transact-SQL
go

create or alter procedure PROCGetAllTeamsInAConference
(@ConferenceName nvarchar(50) 
)
as
BEGIN
    select TeamName, UniversityName
    from Conference C inner join Team T
        on C.ConferenceID = T.ConferenceID
    where ConferenceName = @ConferenceName
END;

-- Execute PROCGetAllTeamsInAConference @ConferenceName = 'Big12';

go
-- Optionality for user input
create or alter procedure PROCGetAllTeamsInAConference
(@ConferenceName nvarchar(50) = null 
)
as
BEGIN
    select TeamName, UniversityName
    from Conference C inner join Team T
        on C.ConferenceID = T.ConferenceID
    --where ConferenceName = @ConferenceName or @ConferenceName is null
    where conferenceName = IsNull(@ConferenceName, conferenceName)
END;

/* 
execute procGetAllTeamsInAConference @conferenceName = 'Big12'
execute procGetAllTeamsInAConference 
*/

GO

create or alter procedure PROCScheduleGame
(@HomeTeamID int,
 @AwayTeamID int,
 @GameDate date, 
 @GameTime time,
 @StadiumID int,
 @gameId int OUTPUT
)
as
BEGIN
    insert into Game(HomeTeamID, AwayTeamID, GameDate, GameTime, StadiumID)
    values (@HomeTeamID, @AwayTeamID, @GameDate, @GameTime, @StadiumID);
    set @gameId = scope_identity()  ;
END;

/*
declare @gameId int;
execute procScheduleGame @HomeTeamID = 1, @AwayTeamID = 2, @GameDate = '2026-11-14', @GameTime = '15:00:00', @StadiumID = 1, @gameId = @gameId output;
print @gameId;
*/

select * from Game;
select * from Game where GameID >= 671;


go 

create or alter procedure PROCUpdateGameScore
(@GameID int,
 @HomeTeamScore int,
 @AwayTeamScore int
)

as
BEGIN
    update Game
    set HomeScore = @HomeTeamScore, AwayScore = @AwayTeamScore
    where GameID = @GameID;
END;    
