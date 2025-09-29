-- ===================================================================
--  DATABASE RESET AND MOCK DATA SEED SCRIPT
-- ===================================================================
--  This script will first DELETE all data from the auction tables,
--  then RESEED the identity columns, and finally INSERT fresh
--  mock data.
-- ===================================================================

-- Use the correct database
USE [MinimalAPIAuctionDB];
GO

SET NOCOUNT ON;
GO

-- 1. DELETE EXISTING DATA (in correct order to avoid foreign key conflicts)
-- ===================================================================
PRINT N'Deleting existing data...';
GO

DELETE FROM [dbo].[Bids];
DELETE FROM [dbo].[AuctionItems];
DELETE FROM [dbo].[User];
GO

-- 2. RESEED IDENTITY COLUMNS (to start IDs from 1 again)
-- ===================================================================
PRINT N'Resetting table identities...';
GO

DBCC CHECKIDENT ('[dbo].[Bids]', RESEED, 0);
DBCC CHECKIDENT ('[dbo].[AuctionItems]', RESEED, 0);
DBCC CHECKIDENT ('[dbo].[User]', RESEED, 0);
GO


-- 3. INSERT MOCK DATA
-- ===================================================================
PRINT N'Inserting new mock data...';
GO

-- Generate Mock Data for User Table (50 Users)
INSERT INTO [dbo].[User] ([FullName], [Email])
VALUES
    ('John Smith', 'john.smith@example.com'), ('Jane Doe', 'jane.doe@example.com'),
    ('Peter Jones', 'peter.jones@example.com'), ('Mary Williams', 'mary.williams@example.com'),
    ('David Brown', 'david.brown@example.com'), ('Jennifer Davis', 'jennifer.davis@example.com'),
    ('Michael Miller', 'michael.miller@example.com'), ('Linda Wilson', 'linda.wilson@example.com'),
    ('William Moore', 'william.moore@example.com'), ('Elizabeth Taylor', 'elizabeth.taylor@example.com'),
    ('Richard Anderson', 'richard.anderson@example.com'), ('Susan Thomas', 'susan.thomas@example.com'),
    ('Joseph Jackson', 'joseph.jackson@example.com'), ('Karen White', 'karen.white@example.com'),
    ('Charles Harris', 'charles.harris@example.com'), ('Patricia Martin', 'patricia.martin@example.com'),
    ('Thomas Thompson', 'thomas.thompson@example.com'), ('Nancy Garcia', 'nancy.garcia@example.com'),
    ('Christopher Martinez', 'christopher.martinez@example.com'), ('Lisa Robinson', 'lisa.robinson@example.com'),
    ('Daniel Clark', 'daniel.clark@example.com'), ('Betty Rodriguez', 'betty.rodriguez@example.com'),
    ('Paul Lewis', 'paul.lewis@example.com'), ('Sandra Lee', 'sandra.lee@example.com'),
    ('Mark Walker', 'mark.walker@example.com'), ('Ashley Hall', 'ashley.hall@example.com'),
    ('Donald Allen', 'donald.allen@example.com'), ('Kimberly Young', 'kimberly.young@example.com'),
    ('George Hernandez', 'george.hernandez@example.com'), ('Donna King', 'donna.king@example.com'),
    ('Kenneth Wright', 'kenneth.wright@example.com'), ('Carol Lopez', 'carol.lopez@example.com'),
    ('Steven Hill', 'steven.hill@example.com'), ('Michelle Scott', 'michelle.scott@example.com'),
    ('Edward Green', 'edward.green@example.com'), ('Amanda Adams', 'amanda.adams@example.com'),
    ('Brian Baker', 'brian.baker@example.com'), ('Melissa Nelson', 'melissa.nelson@example.com'),
    ('Ronald Carter', 'ronald.carter@example.com'), ('Deborah Mitchell', 'deborah.mitchell@example.com'),
    ('Kevin Perez', 'kevin.perez@example.com'), ('Laura Roberts', 'laura.roberts@example.com'),
    ('Jason Turner', 'jason.turner@example.com'), ('Cynthia Phillips', 'cynthia.phillips@example.com'),
    ('Jeffrey Campbell', 'jeffrey.campbell@example.com'), ('Kathleen Parker', 'kathleen.parker@example.com'),
    ('Ryan Evans', 'ryan.evans@example.com'), ('Sharon Edwards', 'sharon.edwards@example.com'),
    ('Gary Collins', 'gary.collins@example.com'), ('Amy Stewart', 'amy.stewart@example.com');
GO

-- Generate Mock Data for AuctionItems Table (50 Items)
INSERT INTO [dbo].[AuctionItems] ([Title], [StartingPrice], [CurrentPrice], [SellerId], [EndDate])
VALUES
    ('Vintage Leather Jacket', 50.00, 50.00, 1, DATEADD(day, 10, GETDATE())),
    ('Antique Wooden Chair', 75.50, 75.50, 2, DATEADD(day, 12, GETDATE())),
    ('Signed Baseball', 120.00, 120.00, 3, DATEADD(day, 8, GETDATE())),
    ('Modern Art Painting', 300.00, 300.00, 4, DATEADD(day, 15, GETDATE())),
    ('Designer Handbag', 250.75, 250.75, 5, DATEADD(day, 7, GETDATE())),
    ('Gaming Laptop', 800.00, 800.00, 6, DATEADD(day, 14, GETDATE())),
    ('Diamond Necklace', 1500.00, 1500.00, 7, DATEADD(day, 20, GETDATE())),
    ('Classic Acoustic Guitar', 450.00, 450.00, 8, DATEADD(day, 9, GETDATE())),
    ('Rare Coin Collection', 600.50, 600.50, 9, DATEADD(day, 18, GETDATE())),
    ('First Edition Book', 220.00, 220.00, 10, DATEADD(day, 6, GETDATE())),
    ('Professional Camera', 1200.00, 1200.00, 11, DATEADD(day, 25, GETDATE())),
    ('Smartwatch', 180.25, 180.25, 12, DATEADD(day, 11, GETDATE())),
    ('Vintage Comic Book', 95.00, 95.00, 13, DATEADD(day, 13, GETDATE())),
    ('Electric Scooter', 350.00, 350.00, 14, DATEADD(day, 16, GETDATE())),
    ('Drone with Camera', 550.00, 550.00, 15, DATEADD(day, 19, GETDATE())),
    ('Leather Sofa', 900.00, 900.00, 16, DATEADD(day, 22, GETDATE())),
    ('Mountain Bike', 650.00, 650.00, 17, DATEADD(day, 17, GETDATE())),
    ('Home Theater System', 1100.00, 1100.00, 18, DATEADD(day, 28, GETDATE())),
    ('Designer Sunglasses', 150.50, 150.50, 19, DATEADD(day, 5, GETDATE())),
    ('Antique Pocket Watch', 400.00, 400.00, 20, DATEADD(day, 21, GETDATE())),
    ('Robot Vacuum Cleaner', 280.00, 280.00, 21, DATEADD(day, 24, GETDATE())),
    ('Pottery Wheel', 320.00, 320.00, 22, DATEADD(day, 26, GETDATE())),
    ('Telescope', 480.00, 480.00, 23, DATEADD(day, 23, GETDATE())),
    ('Espresso Machine', 190.75, 190.75, 24, DATEADD(day, 27, GETDATE())),
    ('Vintage Record Player', 260.00, 260.00, 25, DATEADD(day, 29, GETDATE())),
    ('Kayak', 420.00, 420.00, 26, DATEADD(day, 30, GETDATE())),
    ('Leather Briefcase', 130.00, 130.00, 27, DATEADD(day, 4, GETDATE())),
    ('Smart Home Hub', 90.00, 90.00, 28, DATEADD(day, 3, GETDATE())),
    ('Gold Bracelet', 750.00, 750.00, 29, DATEADD(day, 32, GETDATE())),
    ('Action Figure Collection', 330.50, 330.50, 30, DATEADD(day, 31, GETDATE())),
    ('Treadmill', 850.00, 850.00, 31, DATEADD(day, 35, GETDATE())),
    ('Air Fryer', 70.00, 70.00, 32, DATEADD(day, 2, GETDATE())),
    ('Silk Scarf', 60.25, 60.25, 33, DATEADD(day, 1, GETDATE())),
    ('Fountain Pen', 110.00, 110.00, 34, DATEADD(day, 34, GETDATE())),
    ('Crystal Vase', 140.00, 140.00, 35, DATEADD(day, 33, GETDATE())),
    ('Board Game Collection', 200.00, 200.00, 36, DATEADD(day, 38, GETDATE())),
    ('Electric Toothbrush', 80.00, 80.00, 37, DATEADD(day, 36, GETDATE())),
    ('Cashmere Sweater', 160.00, 160.00, 38, DATEADD(day, 37, GETDATE())),
    ('Wireless Headphones', 210.00, 210.00, 39, DATEADD(day, 40, GETDATE())),
    ('Yoga Mat and Blocks', 55.00, 55.00, 40, DATEADD(day, 39, GETDATE())),
    ('Hard Shell Suitcase', 170.00, 170.00, 41, DATEADD(day, 42, GETDATE())),
    ('Blender', 95.50, 95.50, 42, DATEADD(day, 41, GETDATE())),
    ('Digital Photo Frame', 125.00, 125.00, 43, DATEADD(day, 44, GETDATE())),
    ('Weighted Blanket', 100.00, 100.00, 44, DATEADD(day, 43, GETDATE())),
    ('Standing Desk', 380.00, 380.00, 45, DATEADD(day, 46, GETDATE())),
    ('Air Purifier', 230.00, 230.00, 46, DATEADD(day, 45, GETDATE())),
    ('Camping Tent', 290.00, 290.00, 47, DATEADD(day, 48, GETDATE())),
    ('Rocking Chair', 180.00, 180.00, 48, DATEADD(day, 47, GETDATE())),
    ('Tool Set', 310.00, 310.00, 49, DATEADD(day, 50, GETDATE())),
    ('Wall Mirror', 145.00, 145.00, 50, DATEADD(day, 49, GETDATE()));
GO

-- Generate Mock Data for Bids Table
PRINT N'Generating bids for auction items...';
GO

DECLARE @itemId INT = 1;
WHILE @itemId <= 50
BEGIN
    DECLARE @numBids INT = (SELECT FLOOR(RAND() * 5) + 2); -- Random number of bids between 2 and 6
    DECLARE @bidCounter INT = 1;
    DECLARE @sellerId INT = (SELECT SellerId FROM dbo.AuctionItems WHERE Id = @itemId);

    WHILE @bidCounter <= @numBids
    BEGIN
        DECLARE @bidderId INT;
        -- Get a random bidder who is not the seller
        SELECT TOP 1 @bidderId = Id
        FROM dbo.[User]
        WHERE Id <> @sellerId
        ORDER BY NEWID();

        DECLARE @currentPrice DECIMAL(18, 2) = (SELECT CurrentPrice FROM dbo.AuctionItems WHERE Id = @itemId);
        DECLARE @bidAmount DECIMAL(18, 2) = @currentPrice + (SELECT FLOOR(RAND() * 41) + 10); -- Increase price by 10 to 50

        INSERT INTO dbo.Bids (ItemId, BidderId, BidAmount)
        VALUES (@itemId, @bidderId, @bidAmount);

        UPDATE dbo.AuctionItems
        SET CurrentPrice = @bidAmount
        WHERE Id = @itemId;

        SET @bidCounter = @bidCounter + 1;
    END
    SET @itemId = @itemId + 1;
END;
GO

PRINT N'Database reset and data seeding complete.';
GO