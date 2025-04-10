DECLARE @date DATE = GETDATE(); -- or set manually, e.g., '2024-03-01'
DECLARE @firstDay DATE = DATEFROMPARTS(YEAR(@date), MONTH(@date), 1);
DECLARE @lastDay DATE = EOMONTH(@firstDay);

-- Temporary table to hold calendar structure
DECLARE @calendar TABLE (
    WeekNumber INT,
    Sunday     INT,
    Monday     INT,
    Tuesday    INT,
    Wednesday  INT,
    Thursday   INT,
    Friday     INT,
    Saturday   INT
);

DECLARE @current DATE = @firstDay;
DECLARE @week INT = 1;

WHILE @current <= @lastDay
BEGIN
    DECLARE @dayOfWeek INT = DATEPART(WEEKDAY, @current); 
    -- Adjust so Sunday = 1, Monday = 2, ..., Saturday = 7 regardless of DATEFIRST
    SET @dayOfWeek = ((@@DATEFIRST - 1 + @dayOfWeek - 1) % 7) + 1;

    IF @dayOfWeek = 1 -- Start new week on Sunday
        INSERT INTO @calendar (WeekNumber) VALUES (@week);

    UPDATE @calendar
    SET
        Sunday    = CASE WHEN @dayOfWeek = 1 THEN DAY(@current) ELSE Sunday END,
        Monday    = CASE WHEN @dayOfWeek = 2 THEN DAY(@current) ELSE Monday END,
        Tuesday   = CASE WHEN @dayOfWeek = 3 THEN DAY(@current) ELSE Tuesday END,
        Wednesday = CASE WHEN @dayOfWeek = 4 THEN DAY(@current) ELSE Wednesday END,
        Thursday  = CASE WHEN @dayOfWeek = 5 THEN DAY(@current) ELSE Thursday END,
        Friday    = CASE WHEN @dayOfWeek = 6 THEN DAY(@current) ELSE Friday END,
        Saturday  = CASE WHEN @dayOfWeek = 7 THEN DAY(@current) ELSE Saturday END
    WHERE WeekNumber = @week;

    IF @dayOfWeek = 7 -- After Saturday, increment week number
        SET @week += 1;

    SET @current = DATEADD(DAY, 1, @current);
END;

SELECT Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
FROM @calendar;
