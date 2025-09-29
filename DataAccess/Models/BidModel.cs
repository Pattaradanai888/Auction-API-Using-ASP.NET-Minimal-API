namespace DataAccess.Models;

public class BidModel
{
    public int Id { get; set; }
    public int ItemId { get; set; }
    public int BidderId { get; set; }
    public decimal BidAmount { get; set; }
    public bool IsWinning { get; set; }
    public DateTime BidDate { get; set; } = DateTime.UtcNow;
    
    // Navigation properties for easier debugging and API responses
    public string BidderName { get; set; } = string.Empty;
    public string AuctionTitle { get; set; } = string.Empty;
}