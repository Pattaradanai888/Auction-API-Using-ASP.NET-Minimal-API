using DataAccess.DbAccess;
using DataAccess.Models;

namespace DataAccess.Data;

public class BidData : IBidData
{
    private readonly ISqlDataAccess _db;

    public BidData(ISqlDataAccess db)
    {
        _db = db;
    }

    public async Task<int> PlaceBid(BidModel bid)
    {
        var result = await _db.LoadData<int, dynamic>("dbo.spBid_Insert", new
        {
            bid.ItemId,
            bid.BidderId,
            bid.BidAmount,
            bid.BidDate
        });
        
        return result.FirstOrDefault();
    }

    public Task<IEnumerable<BidModel>> GetBidsByAuction(int auctionId) =>
        _db.LoadData<BidModel, dynamic>("dbo.spBid_GetByAuction", new { AuctionId = auctionId });

    public Task<IEnumerable<BidModel>> GetBidsByUser(int userId) =>
        _db.LoadData<BidModel, dynamic>("dbo.spBid_GetByUser", new { UserId = userId });

    public async Task<BidModel?> GetHighestBidForAuction(int auctionId)
    {
        var result = await _db.LoadData<BidModel, dynamic>("dbo.spBid_GetHighestByAuction", new { AuctionId = auctionId });
        return result.FirstOrDefault();
    }

    public Task UpdateWinningBid(int auctionId, int bidId) =>
        _db.SaveData("dbo.spBid_UpdateWinning", new { AuctionId = auctionId, BidId = bidId });
}