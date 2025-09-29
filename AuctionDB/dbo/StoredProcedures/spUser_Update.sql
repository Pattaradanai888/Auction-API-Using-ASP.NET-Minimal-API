CREATE PROCEDURE [dbo].[spUser_Update]
	@Id INT,
	@FullName NVARCHAR(256),
	@Email NVARCHAR(256)
AS
begin
	update dbo.[User]
	set FullName = @FullName, Email = @Email
	WHERE Id = @Id AND IsActive = 1
end