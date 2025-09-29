CREATE PROCEDURE [dbo].[spBid_Insert]
	@ItemId int,
	@BidderId int,
	@BidAmount decimal(18,2),
	@BidDate datetime2
AS
begin
	set nocount on;
	
	INSERT INTO dbo.Bids (ItemId, BidderId, BidAmount, BidDate)
	VALUES (@ItemId, @BidderId, @BidAmount, @BidDate);
	
	UPDATE dbo.AuctionItems 
	SET CurrentPrice = @BidAmount 
	WHERE Id = @ItemId;
	
	SELECT SCOPE_IDENTITY() as NewBidId;
end