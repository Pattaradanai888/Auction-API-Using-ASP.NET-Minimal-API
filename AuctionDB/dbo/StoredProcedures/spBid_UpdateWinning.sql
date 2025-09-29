CREATE PROCEDURE [dbo].[spBid_UpdateWinning]
	@AuctionId int,
	@BidId int
AS
begin
	set nocount on;
	
	UPDATE dbo.Bids 
	SET IsWinning = 0 
	WHERE ItemId = @AuctionId;
	
	UPDATE dbo.Bids 
	SET IsWinning = 1 
	WHERE Id = @BidId AND ItemId = @AuctionId;
end