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
}
