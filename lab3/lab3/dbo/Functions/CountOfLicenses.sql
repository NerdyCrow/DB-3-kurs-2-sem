create function CountOfLicenses()
returns int
as
begin
declare @count int;
select @count=count(*) from Licenses
return @count;
end;