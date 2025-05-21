-- Set target month and year
DECLARE @Year INT = 2024;
DECLARE @Month INT = 5;

-- Compute date boundaries
DECLARE @StartDate DATE = DATEFROMPARTS(@Year, @Month, 1);
DECLARE @EndDate DATE = EOMONTH(@StartDate);

-- Use a table to store date range
DECLARE @Dates TABLE (CalendarDate DATE);

-- Fill @Dates with all days in the target month
DECLARE @CurrentDate DATE = @StartDate;
WHILE @CurrentDate <= @EndDate
BEGIN
    INSERT INTO @Dates VALUES (@CurrentDate);
    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
END;

-- Build final calendar table with Sunday as the first column
;WITH Labeled AS (
    SELECT 
        CalendarDate,
        DATENAME(WEEKDAY, CalendarDate) AS DayName,
        DATEPART(WEEK, CalendarDate) - DATEPART(WEEK, @StartDate) + 1 AS WeekNum,
        DATEPART(WEEKDAY, CalendarDate) AS WeekdayNumber,
        DAY(CalendarDate) AS DayNum
    FROM @Dates
),
Normalized AS (
    SELECT 
        CalendarDate,
        WeekNum,
        DayNum,
        CASE 
            WHEN DATEPART(WEEKDAY, CalendarDate) = 1 THEN 1  -- Sunday
            WHEN DATEPART(WEEKDAY, CalendarDate) = 2 THEN 2  -- Monday
            WHEN DATEPART(WEEKDAY, CalendarDate) = 3 THEN 3  -- Tuesday
            WHEN DATEPART(WEEKDAY, CalendarDate) = 4 THEN 4  -- Wednesday
            WHEN DATEPART(WEEKDAY, CalendarDate) = 5 THEN 5  -- Thursday
            WHEN DATEPART(WEEKDAY, CalendarDate) = 6 THEN 6  -- Friday
            WHEN DATEPART(WEEKDAY, CalendarDate) = 7 THEN 7  -- Saturday
        END AS DayOfWeekIndex
    FROM Labeled
)
SELECT 
    WeekNum,
    MAX(CASE WHEN DayOfWeekIndex = 1 THEN DayNum END) AS Sunday,
    MAX(CASE WHEN DayOfWeekIndex = 2 THEN DayNum END) AS Monday,
    MAX(CASE WHEN DayOfWeekIndex = 3 THEN DayNum END) AS Tuesday,
    MAX(CASE WHEN DayOfWeekIndex = 4 THEN DayNum END) AS Wednesday,
    MAX(CASE WHEN DayOfWeekIndex = 5 THEN DayNum END) AS Thursday,
    MAX(CASE WHEN DayOfWeekIndex = 6 THEN DayNum END) AS Friday,
    MAX(CASE WHEN DayOfWeekIndex = 7 THEN DayNum END) AS Saturday
FROM Normalized
GROUP BY WeekNum
ORDER BY WeekNum;
