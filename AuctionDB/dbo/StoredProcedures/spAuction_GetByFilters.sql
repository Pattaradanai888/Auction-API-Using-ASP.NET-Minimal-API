CREATE PROCEDURE [dbo].[spAuction_GetByFilters]
    @MinPrice DECIMAL(18,2),
    @MaxPrice DECIMAL(18,2),
    @Category NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT Id, Title, StartingPrice, CurrentPrice, 
           SellerId, IsActive, EndDate, CreatedAt,
           '' AS Description, @Category AS Category, CreatedAt AS StartDate
    FROM dbo.AuctionItems
    WHERE IsActive = 1
        AND CurrentPrice >= @MinPrice
        AND CurrentPrice <= @MaxPrice
        AND EndDate > GETUTCDATE()
    ORDER BY EndDate ASC;
END