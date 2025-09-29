CREATE PROCEDURE [dbo].[spAuction_GetAll]
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT Id, Title, StartingPrice, CurrentPrice, 
           SellerId, IsActive, EndDate, CreatedAt,
           '' AS Description, '' AS Category, CreatedAt AS StartDate
    FROM dbo.AuctionItems
    WHERE IsActive = 1
    ORDER BY CreatedAt DESC;
END