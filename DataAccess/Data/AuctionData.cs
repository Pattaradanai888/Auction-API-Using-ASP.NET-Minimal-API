// file: DataAccess/Data/AuctionData.cs
using DataAccess.DbAccess;
using DataAccess.Models;

namespace DataAccess.Data;

public class AuctionData : IAuctionData
{
    private readonly ISqlDataAccess _db;

    public AuctionData(ISqlDataAccess db)
    {
        _db = db;
    }

    public Task<IEnumerable<AuctionModel>> GetAuctions() =>
        _db.LoadData<AuctionModel, dynamic>("dbo.spAuction_GetAll", new { });

    public Task<AuctionModel?> GetAuctionById(int id) =>
        _db.LoadData<AuctionModel, dynamic>("dbo.spAuction_GetById", new { Id = id })
        .ContinueWith(t => t.Result.FirstOrDefault());

    // This method accepts 3+ parameters and outputs 5+ data fields
    public Task<IEnumerable<AuctionModel>> GetAuctionsByFilters(decimal minPrice, decimal maxPrice, string category) =>
        _db.LoadData<AuctionModel, dynamic>("dbo.spAuction_GetByFilters", new 
        { 
            MinPrice = minPrice, 
            MaxPrice = maxPrice, 
            Category = category 
        });

    // Another method with 3+ parameters
    public Task<IEnumerable<AuctionModel>> GetActiveAuctionsBySeller(int sellerId, bool activeOnly, string sortBy) =>
        _db.LoadData<AuctionModel, dynamic>("dbo.spAuction_GetBySeller", new 
        { 
            SellerId = sellerId, 
            ActiveOnly = activeOnly, 
            SortBy = sortBy 
        });

    public Task InsertAuction(AuctionModel auction) =>
        _db.SaveData("dbo.spAuction_Insert", new
        {
            auction.Title,
            auction.Description,
            auction.StartingPrice,
            auction.CurrentPrice,
            auction.StartDate,
            auction.EndDate,
            auction.SellerId,
            auction.Category,
            auction.IsActive,
            auction.CreatedAt
        });

    public Task UpdateAuction(AuctionModel auction) =>
        _db.SaveData("dbo.spAuction_Update", auction);

    public Task DeleteAuction(int id) =>
        _db.SaveData("dbo.spAuction_Delete", new { Id = id });
}