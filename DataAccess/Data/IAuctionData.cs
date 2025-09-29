using DataAccess.Models;

namespace DataAccess.Data;

public interface IAuctionData
{
    Task DeleteAuction(int id);
    Task<AuctionModel?> GetAuctionById(int id);
    Task<IEnumerable<AuctionModel>> GetAuctions();
    Task<IEnumerable<AuctionModel>> GetAuctionsByFilters(decimal minPrice, decimal maxPrice, string category);
    Task<IEnumerable<AuctionModel>> GetActiveAuctionsBySeller(int sellerId, bool activeOnly, string sortBy);
    Task InsertAuction(AuctionModel auction);
    Task UpdateAuction(AuctionModel auction);
}