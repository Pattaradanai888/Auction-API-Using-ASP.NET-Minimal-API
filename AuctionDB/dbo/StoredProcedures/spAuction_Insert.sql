CREATE PROCEDURE [dbo].[spAuction_Insert]
    @Title NVARCHAR(256),
    @Description NVARCHAR(1000),
    @StartingPrice DECIMAL(18,2),
    @CurrentPrice DECIMAL(18,2),
    @StartDate DATETIME2(7),
    @EndDate DATETIME2(7),
    @SellerId INT,
    @Category NVARCHAR(100),
    @IsActive BIT,
    @CreatedAt DATETIME2(7)
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO dbo.AuctionItems (Title, StartingPrice, CurrentPrice, 
                                 SellerId, IsActive, EndDate, CreatedAt)
    VALUES (@Title, @StartingPrice, @CurrentPrice, 
            @SellerId, @IsActive, @EndDate, @CreatedAt);
END