/*
	Author:
		Dmitry Spitsyn
	Create date:
		21.02.2008
	Description:	
		Following script display disk free space.
	Limitations of this version:
		- None. 
*/
SET NOCOUNT ON
GO
USE master
GO
CREATE TABLE #iDrive (DriveLetter CHAR(1), FreeMB INT)
INSERT INTO #iDrive
EXEC xp_fixeddrives
DECLARE @DriveLetter CHAR(1), @FreeResultMB VARCHAR(10), @FreeMB INT, @FreeGB VARCHAR(10)
DECLARE DriveCursor CURSOR
FOR SELECT * FROM #iDrive WHERE DriveLetter IN ('H','I','Q')
	OPEN DriveCursor
	FETCH NEXT FROM DriveCursor INTO @DriveLetter, @FreeMB
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @FreeResultMB = CAST(@FreeMB AS VARCHAR(10)) + ' MB'
			SET @FreeGB = CAST(@FreeMB/1024 AS VARCHAR(10)) + ' GB'
			PRINT 'Drive ' + @DriveLetter + ' has ' + @FreeResultMB + ' or ' + @FreeGB + ' free space.'
				--CASE @DriveLetter
				--WHEN 'H' THEN @DriveLetter + ' - (ELVISdev):'
				--WHEN 'I' THEN @DriveLetter + ' - (ELVISref):'
				--WHEN 'Q' THEN @DriveLetter + ' - (ELVISpro):' END + ' has ' + @FreeResultMB + ' or ' + @FreeGB + ' free space.'
			FETCH NEXT FROM DriveCursor INTO @DriveLetter, @FreeMB
		END
	CLOSE DriveCursor
DEALLOCATE DriveCursor
GO
DROP Table #iDrive
GO
