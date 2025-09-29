CREATE PROCEDURE [dbo].[spBid_GetByAuction]
	@AuctionId int
AS
begin
	set nocount on;
	
	SELECT 
		b.Id,
		b.ItemId,
		b.BidderId,
		b.BidAmount,
		b.IsWinning,
		b.BidDate,
		u.FullName as BidderName,
		a.Title as AuctionTitle
	FROM dbo.Bids b
	INNER JOIN dbo.[User] u ON b.BidderId = u.Id
	INNER JOIN dbo.AuctionItems a ON b.ItemId = a.Id
	WHERE b.ItemId = @AuctionId
	ORDER BY b.BidAmount DESC, b.BidDate ASC;
end