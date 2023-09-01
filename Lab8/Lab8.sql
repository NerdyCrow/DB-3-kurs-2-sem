alter database open;
CREATE TABLESPACE blob_lab
    DATAFILE 'C:\Users\victo\AppData\Roaming\SQL Developer\lob_ts.dbf'
    SIZE 1000 m
    AUTOEXTEND ON NEXT 500M
    MAXSIZE 2000M
    EXTENT MANAGEMENT LOCAL;
    
  CREATE USER lob_user IDENTIFIED BY 12345
    DEFAULT TABLESPACE blob_lab QUOTA UNLIMITED ON blob_lab
    ACCOUNT UNLOCK;
  
  
  
  