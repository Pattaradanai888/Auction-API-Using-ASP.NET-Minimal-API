CREATE PROCEDURE [dbo].[spBid_GetByUser]
	@UserId int
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
	WHERE b.BidderId = @UserId
	ORDER BY b.BidDate DESC;
end