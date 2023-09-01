CREATE FUNCTION udf_TotalCostOfPurchasedLicenses() returns INT 
AS
BEGIN  
     DECLARE @sum INT = 
	 (SELECT sum(s.Price) 
	 FROM vw_ActiveLicenses l 
	 INNER JOIN 
	 Software s on l.SoftwareId = s.Id);    
     RETURN @sum;
END; 