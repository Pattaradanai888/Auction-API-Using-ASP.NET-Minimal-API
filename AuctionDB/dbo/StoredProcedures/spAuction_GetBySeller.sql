CREATE PROCEDURE [dbo].[spAuction_GetBySeller]
    @SellerId INT,
    @ActiveOnly BIT,
    @SortBy NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT Id, Title, StartingPrice, CurrentPrice, 
           SellerId, IsActive, EndDate, CreatedAt,
           '' AS Description, '' AS Category, CreatedAt AS StartDate
    FROM dbo.AuctionItems
    WHERE SellerId = @SellerId
        AND (@ActiveOnly = 0 OR IsActive = 1)
    ORDER BY 
        CASE 
            WHEN @SortBy = 'Price' THEN CurrentPrice
            ELSE 0
        END DESC,
        CASE 
            WHEN @SortBy = 'EndDate' THEN EndDate
            WHEN @SortBy = 'CreatedAt' THEN CreatedAt
            ELSE CreatedAt
        END DESC;
END