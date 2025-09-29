CREATE PROCEDURE [dbo].[spAuction_Update]
    @Id INT,
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
    
    UPDATE dbo.AuctionItems
    SET Title = @Title,
        StartingPrice = @StartingPrice,
        CurrentPrice = @CurrentPrice,
        SellerId = @SellerId,
        IsActive = @IsActive,
        EndDate = @EndDate
    WHERE Id = @Id;
END