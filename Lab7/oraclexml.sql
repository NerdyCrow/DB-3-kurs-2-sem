create table Report (
id number generated by default as identity primary key ,
xml_column XMLType 
);

CREATE OR REPLACE PROCEDURE GenerateXML
IS
v_xml XMLTYPE;
BEGIN
SELECT XMLELEMENT("Data", XMLAGG(XMLELEMENT("row",
XMLFOREST(s.Name AS "SoftwareName",
s.Version AS "SoftwareVersion",
s.Price AS "SoftwarePrice",
o.ContactId AS "OwnerContactId",
c.ContactId AS "CustomerContactId",
l.Title AS "LicenseTitle",
l.PaymentDate AS "LicensePaymentDate",
l.ExpiryDate AS "LicenseExpiryDate",
lh.Title AS "LicenseHistoryTitle",
lh.PaymentDate AS "LicenseHistoryPaymentDate",
lh.ExpiryDate AS "LicenseHistoryExpiryDate",
SYSDATE AS "Timestamp"
))
))
INTO v_xml
FROM Software s
INNER JOIN Owners o ON s.OwnerId = o.Id
INNER JOIN Licenses l ON s.Id = l.SoftwareId
INNER JOIN Customers c ON l.CustomerId = c.Id
LEFT JOIN LicensesHistory lh ON l.Id = lh.LicenseId;
DBMS_OUTPUT.PUT_LINE(v_xml.getClobVal());
END;


exec GENERATEXML


---task3
CREATE OR REPLACE PROCEDURE InsertReportXML
AS
v_xml XMLTYPE;
BEGIN
SELECT XMLELEMENT("Data", XMLAGG(XMLELEMENT("row",
XMLFOREST(s.Name AS "SoftwareName",
s.Version AS "SoftwareVersion",
s.Price AS "SoftwarePrice",
o.ContactId AS "OwnerContactId",
c.ContactId AS "CustomerContactId",
l.Title AS "LicenseTitle",
l.PaymentDate AS "LicensePaymentDate",
l.ExpiryDate AS "LicenseExpiryDate",
lh.Title AS "LicenseHistoryTitle",
lh.PaymentDate AS "LicenseHistoryPaymentDate",
lh.ExpiryDate AS "LicenseHistoryExpiryDate",
SYSDATE AS "Timestamp"
))
))
INTO v_xml
FROM Software s
INNER JOIN Owners o ON s.OwnerId = o.Id
INNER JOIN Licenses l ON s.Id = l.SoftwareId
INNER JOIN Customers c ON l.CustomerId = c.Id
LEFT JOIN LicensesHistory lh ON l.Id = lh.LicenseId;
INSERT INTO Report (xml_column) VALUES (v_xml);
END;

exec InsertReportXML
select id, EXTRACT(xml_column,'/*').getClobVal() from Report;

--task4+
create index XMLIndexx on Report(Xml_column)
indextype is XDB.XMLIndex
parameters ('paths (include (/Data))');-------------------------

--task5
CREATE OR REPLACE PROCEDURE SelectData(p_query IN VARCHAR2)
IS
v_xml XMLTYPE;
BEGIN
SELECT EXTRACT(xml_column, '/' || p_query) INTO v_xml FROM Report;
DBMS_OUTPUT.PUT_LINE(v_xml.getClobVal());
END;

exec SelectData('/Data/row/SoftwareName')