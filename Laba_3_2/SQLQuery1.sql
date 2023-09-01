exec sp_configure 'clr enabled', 1; 
reconfigure;

exec sp_configure 'show advanced options', 1;
reconfigure;
exec sp_configure 'clr strict security', 0;
reconfigure;

drop procedure dbo.ReadFromFile
drop ASSEMBLY Lab3
drop type License

ALTER DATABASE SoftLicenseManagement SET TRUSTWORTHY ON

CREATE ASSEMBLY Lab3 FROM 
'D:\3 kurs 2 sem\BD\Laba_3_2\Laba_3_2\bin\Debug\Laba_3_2.dll' 
WITH PERMISSION_SET = UNSAFE;





CREATE TYPE License EXTERNAL NAME Lab3.License;
declare @Lic as License;
set @Lic = '1,Victor';
print @Lic.TITLE;


CREATE PROCEDURE dbo.ReadFromFile
@filename nvarchar(255),
@result nvarchar(255) output
AS EXTERNAL NAME Lab3.[Laba_3_2.StoredProcedure].ReadFromFile;

DECLARE @result nvarchar(255) 
exec dbo.ReadFromFile 'D:\lab3.txt',@result OUTPUT; 
PRINT @result



