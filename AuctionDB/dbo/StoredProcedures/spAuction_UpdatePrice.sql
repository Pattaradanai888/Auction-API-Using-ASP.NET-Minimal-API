CREATE PROCEDURE [dbo].[spAuction_UpdatePrice]
	@Id int,
	@CurrentPrice decimal(18,2)
AS
begin
	set nocount on;
	
	UPDATE dbo.AuctionItems 
	SET CurrentPrice = @CurrentPrice 
	WHERE Id = @Id;
end