using DataAccess.Models;

namespace DataAccess.Data;

public interface IBidData
{
    Task<int> PlaceBid(BidModel bid);
    Task<IEnumerable<BidModel>> GetBidsByAuction(int auctionId);
    Task<IEnumerable<BidModel>> GetBidsByUser(int userId);
    Task<BidModel?> GetHighestBidForAuction(int auctionId);
    Task UpdateWinningBid(int auctionId, int bidId);
}