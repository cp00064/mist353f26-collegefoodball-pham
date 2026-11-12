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

