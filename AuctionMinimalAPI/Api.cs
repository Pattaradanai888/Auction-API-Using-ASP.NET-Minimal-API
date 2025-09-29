using System.Threading.Tasks;

namespace AuctionMinimalAPI;

public static class Api
{
    public static void ConfigureApi(this WebApplication app)
    {
        // User endpoints
        app.MapGet("/Users", GetUsers);
        app.MapGet("/Users/{id}", GetUser);
        app.MapPost("/Users", InsertUser);
        app.MapPut("/Users", UpdateUser);
        app.MapDelete("/Users", DeleteUser);

        // Auction endpoints
        app.MapGet("/Auctions", GetAuctions);
        app.MapGet("/Auctions/{id}", GetAuction);
        app.MapGet("/Auctions/filter", GetAuctionsByFilters);
        app.MapGet("/Auctions/seller/{sellerId}", GetAuctionsBySeller);
        app.MapPost("/Auctions", InsertAuction);
        app.MapPut("/Auctions", UpdateAuction);
        app.MapDelete("/Auctions", DeleteAuction);

        // Bidding endpoints
        app.MapPost("/Bids", PlaceBid);
        app.MapGet("/Bids/auction/{auctionId}", GetBidsByAuction);
        app.MapGet("/Bids/user/{userId}", GetBidsByUser);
        app.MapGet("/Bids/highest/{auctionId}", GetHighestBid);
    }

    // User methods
    private static async Task<IResult> GetUsers(IUserData data)
    {
        try
        {
            return Results.Ok(await data.GetUsers());
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    private static async Task<IResult> GetUser(int id, IUserData data)
    {
        try
        {
            var results = await data.GetUserById(id);
            if (results == null) return Results.NotFound();
            return Results.Ok(results);
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    private static async Task<IResult> InsertUser(UserModel user, IUserData data)
    {
        try
        {
            await data.InsertUser(user);
            return Results.Ok();
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    private static async Task<IResult> UpdateUser(UserModel user, IUserData data)
    {
        try
        {
            await data.UpdateUser(user);
            return Results.Ok();
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    private static async Task<IResult> DeleteUser(int id, IUserData data)
    {
        try
        {
            await data.DeleteUser(id);
            return Results.Ok();
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    // Auction methods
    private static async Task<IResult> GetAuctions(IAuctionData data)
    {
        try
        {
            return Results.Ok(await data.GetAuctions());
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    private static async Task<IResult> GetAuction(int id, IAuctionData data)
    {
        try
        {
            var results = await data.GetAuctionById(id);
            if (results == null) return Results.NotFound();
            return Results.Ok(results);
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    private static async Task<IResult> GetAuctionsByFilters(decimal minPrice, decimal maxPrice, string category, IAuctionData data)
    {
        try
        {
            return Results.Ok(await data.GetAuctionsByFilters(minPrice, maxPrice, category ?? ""));
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    private static async Task<IResult> GetAuctionsBySeller(int sellerId, bool activeOnly, string sortBy, IAuctionData data)
    {
        try
        {
            return Results.Ok(await data.GetActiveAuctionsBySeller(sellerId, activeOnly, sortBy ?? "CreatedAt"));
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    private static async Task<IResult> InsertAuction(AuctionModel auction, IAuctionData data)
    {
        try
        {
            await data.InsertAuction(auction);
            return Results.Ok();
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    private static async Task<IResult> UpdateAuction(AuctionModel auction, IAuctionData data)
    {
        try
        {
            await data.UpdateAuction(auction);
            return Results.Ok();
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    private static async Task<IResult> DeleteAuction(int id, IAuctionData data)
    {
        try
        {
            await data.DeleteAuction(id);
            return Results.Ok();
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    // Bidding methods
    private static async Task<IResult> PlaceBid(BidModel bid, IBidData bidData, IAuctionData auctionData)
    {
        try
        {
            if (bid.BidAmount <= 0 || bid.ItemId <= 0 || bid.BidderId <= 0)
            {
                return Results.BadRequest("Invalid bid data provided");
            }

            var auction = await auctionData.GetAuctionById(bid.ItemId);
            if (auction == null)
            {
                return Results.NotFound("Auction not found");
            }

            if (!auction.IsActive || auction.EndDate < DateTime.UtcNow)
            {
                return Results.BadRequest("Auction is not active or has ended");
            }

            if (bid.BidAmount <= auction.CurrentPrice)
            {
                return Results.BadRequest($"Bid must be higher than current price of ${auction.CurrentPrice}");
            }

            var bidId = await bidData.PlaceBid(bid);
            return Results.Ok(new { BidId = bidId, Success = true });
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    private static async Task<IResult> GetBidsByAuction(int auctionId, IBidData data)
    {
        try
        {
            if (auctionId <= 0)
            {
                return Results.BadRequest("Invalid auction ID");
            }

            var bids = await data.GetBidsByAuction(auctionId);
            return Results.Ok(bids);
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    private static async Task<IResult> GetBidsByUser(int userId, IBidData data)
    {
        try
        {
            if (userId <= 0)
            {
                return Results.BadRequest("Invalid user ID");
            }

            var bids = await data.GetBidsByUser(userId);
            return Results.Ok(bids);
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }

    private static async Task<IResult> GetHighestBid(int auctionId, IBidData data)
    {
        try
        {
            if (auctionId <= 0)
            {
                return Results.BadRequest("Invalid auction ID");
            }

            var highestBid = await data.GetHighestBidForAuction(auctionId);
            if (highestBid == null)
            {
                return Results.NotFound("No bids found for this auction");
            }

            return Results.Ok(highestBid);
        }
        catch (Exception ex)
        {
            return Results.Problem(ex.Message);
        }
    }
}
