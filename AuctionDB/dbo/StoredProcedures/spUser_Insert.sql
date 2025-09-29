CREATE PROCEDURE [dbo].[spUser_Insert]
	@FullName NVARCHAR(256),
	@Email NVARCHAR(256)
AS
begin
	insert into dbo.[User] (FullName, Email)
	values (@FullName, @Email)
end
