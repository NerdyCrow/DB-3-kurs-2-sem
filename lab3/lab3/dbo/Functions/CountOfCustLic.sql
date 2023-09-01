
create function CountOfCustLic(@id int)
returns int
as
begin
declare @count int;
select @count=count(*) from Licenses where Licenses.CustomerId=@id
return @count;
end;