-- 1. actions for WeeklyPredictionResults 

declare @startDate date;


select U.AppUserID, U.FirstName, U.LastName, U.Email, max (WPR.numberOfCorrectPredictions) 
from WeeklyPredictionResults WPR join AppUser U on WPR.AppUserID = U.AppUserID
where WPR.startDate=@startDate
--where getdate() between WPR.StartDate and dateadd(day, 6, WPR.startDate)
group by U.AppUserID, U.FirstName, U.LastName, U.Email;