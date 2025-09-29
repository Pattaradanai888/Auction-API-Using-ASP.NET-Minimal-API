CREATE PROCEDURE [dbo].[spAuction_GetById]
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT Id, Title, StartingPrice, CurrentPrice, 
           SellerId, IsActive, EndDate, CreatedAt,
           '' AS Description, '' AS Category, CreatedAt AS StartDate
    FROM dbo.AuctionItems
    WHERE Id = @Id;
END