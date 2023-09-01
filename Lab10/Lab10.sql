
--1.	�������� � ���������, ����� ����� �������������� ������������ ��� ���������� SQL Server.
SELECT SERVERPROPERTY('IsIntegratedSecurityOnly')
--- 1 -�������������� Windows.  0 -  �������������� SQL Server.


-- 2.	������� ����������� ������� ������, ���� � �������������. 
create login Kolya with password = '12345678';
create login Sasha with password = '12345678';
create user Kolya for login Kolya;
create user Sasha for login Sasha;
grant connect on database :: SoftLicenseManagement to Kolya;
grant connect on database :: SoftLicenseManagement to Kolya;
grant create function on database :: SoftLicenseManagement to Kolya;
grant create procedure on database :: SoftLicenseManagement to Kolya;
grant create database on database :: SoftLicenseManagement to Kolya;
grant create table on database :: SoftLicenseManagement to Kolya;
grant select, insert, update,delete on database :: SoftLicenseManagement to Kolya;
go

-- 3.	����������������� ������������� ���� ��� ����� ��������� � ���� ������
deny select on Licenses to Sasha;

EXECUTE AS USER = 'Kolya';

select * from Licenses;

EXECUTE AS USER =  'Sasha';
select * from Licenses;


-- TAsk 4	������� ��� ���������� SQL Server ������ ������
use master

SELECT SUSER_SNAME();
EXECUTE AS USER = 'Kirill';
go
create server audit ServerAudit
to file
(
    filepath = 'C:\test\',
    maxsize = 1GB,
    max_rollover_files = 0,
    reserve_disk_space = off
)
with
(
    queue_delay = 1000,
    on_failure = continue
)
alter server audit ServerAudit with ( state = on );
revert
select * from fn_get_audit_file( 'C:\test\ServerAudit_94F2DBFD-CC78-450D-88AA-A63FB45BD198_0_133293300531510000.sqlaudit', null, null ) order by event_time desc,sequence_number


-- Task 55.	������ ��� ���������� ������ ����������� ������������.
CREATE SERVER AUDIT SPECIFICATION ServerAuditSpecification
FOR SERVER AUDIT ServerAudit
    ADD (FAILED_LOGIN_GROUP);
GO

-- Task 66.	��������� ��������� �����, ������������������ ������ ������.
ALTER SERVER AUDIT ServerAudit
WITH (STATE = ON);
GO
select * from fn_get_audit_file( 'C:\test\ServerAudit_94F2DBFD-CC78-450D-88AA-A63FB45BD198_0_133299907416240000.sqlaudit', null, null ) order by event_time desc,sequence_number

-- Task 77.	������� ����������� ������� ������.
create server audit DataBaseAudit
to file
(
    filepath = 'C:\test\database\',
    maxsize = 10GB,
    max_rollover_files = 0,
    reserve_disk_space = off
)
with
(
    queue_delay = 1000,
    on_failure = continue
)

-- Task 88.	������ ��� ������ ����������� ������������.
create database audit specification CustomAuditSpecific
for server audit DataBaseAudit
add (select, insert, update , delete on Licenses by dbo )
go



-- Task 99.	��������� ����� ��, ������������������ ������ ������.
alter server audit DataBaseAudit
with (state = on);

select * from fn_get_audit_file( 'C:\test\database\DataBaseAudit_10AE4906-5548-40A8-8EE0-07420D3AC2EE_0_133293309933900000.sqlaudit', null, null ) order by event_time desc,sequence_number
go;

-- Task 1010.	���������� ����� �� � �������.
alter server audit DataBaseAudit
with (state = off);
go;

alter server audit ServerAudit
with (state = off);
go

-- Task 1111.	������� ��� ���������� SQL Server ������������� ���� ����������.
create asymmetric key SomeKey
    with algorithm = rsa_2048
    encryption by password = 'labkey';

-- Task 1212.	����������� � ������������ ������ ��� ������ ����� �����.
declare @text NVARCHAR(100);
declare @cipher varbinary(512);

set @text = 'Victor slemnev';
print @text;

set @cipher = ENCRYPTBYASYMKEY(ASYMKEY_ID('SomeKey'), @text);
print @cipher;

set @text = cast(DECRYPTBYASYMKEY(ASYMKEY_ID('SomeKey'), @cipher, N'labkey') as nvarchar(100));
print @text;

-- Task 1313.	������� ��� ���������� SQL Server ����������.
create certificate SomeCertificate
    encryption by password = N'labkey'
    with subject = N'Some Certificate',
    expiry_date = N'20231010'
-- drop certificate SomeCertificate;
select * from sys.certificates;
drop certificate SomeCertificate;

-- Task 1414.	����������� � ������������ ������ ��� ������ ����� �����������.
declare @text nvarchar(100);
declare @decrypt nvarchar(100);
declare @cipher varbinary(max);

set @text = 'Slemnev Victor';
print @text;

set @cipher = ENCRYPTBYCERT(CERT_ID('SomeCertificate'), @text);
print @cipher;

set @decrypt = cast(DECRYPTBYCERT(CERT_ID('SomeCertificate'), @cipher, N'labkey') as nvarchar(max));
print @decrypt;

-- Task 1515.	������� ��� ���������� SQL Server ������������ ���� ���������� ������.
create symmetric key SymmetricKey
    with algorithm = AES_256
    encryption by password = 'labkey';

open symmetric key SymmetricKey
    decryption by password = N'labkey';

create symmetric key SymmetricKeyData
    with algorithm = AES_256
    encryption by symmetric key SymmetricKey;

open symmetric key SymmetricKeyData
    decryption by symmetric key SymmetricKey;

select * from sys.symmetric_keys;

-- Task 1616.	����������� � ������������ ������ ��� ������ ����� �����.
declare @text nvarchar(100);
declare @decrypt nvarchar(100);
declare @cipher varbinary(max);

set @text = 'Slemnev Victor';
print @text;

set @cipher = ENCRYPTBYKEY(KEY_GUID('SymmetricKeyData'), @text);
print @cipher;

set @decrypt = cast(DECRYPTBYKEY(@cipher) as nvarchar(max));
print @decrypt;

-- Task 1717.	������������������ ���������� ���������� ���� ������.
use master;
create master key encryption by password = 'labkey';

create certificate ServerCert
    with subject = 'DEK Certificate';

use SoftLicenseManagement;

create database encryption key
with algorithm = aes_256
encryption by server certificate ServerCert;

alter database SoftLicenseManagement
    set encryption on;
alter database SoftLicenseManagement
    set encryption off;

select * from sys.dm_database_encryption_keys;
SELECT *
FROM sys.dm_database_encryption_keys
WHERE encryption_state = 3;

-- Task 1818.	������������������ ���������� �����������.
select hashbytes('sha1', 'victor, slemnev victor =)');

-- Task 1919.	������������������ ���������� ��� ��� ������ �����������.

use master
select SignByCert(Cert_Id( 'SomeCertificate' ),'Secrect Info', N'labkey')

-- Task 2020.	������� ��������� ����� ����������� ������ � ������������.
backup service master key to file = 'C:\test\backup_master_key.dat'
    encryption by password = '#asdr3adkDJSa$%z!~';

backup certificate SomeCertificate to file = N'C:\test\SomeCertificate.crt';



SELECT SERVERPROPERTY('productversion'), SERVERPROPERTY ('productlevel'), SERVERPROPERTY ('edition')


