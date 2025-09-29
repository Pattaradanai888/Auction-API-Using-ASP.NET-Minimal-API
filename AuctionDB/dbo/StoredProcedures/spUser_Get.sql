CREATE PROCEDURE [dbo].[spUser_Get]
	@Id int
AS
begin
	select Id, FullName, Email, CreatedAt, IsActive 
	from dbo.[User]
	where Id = @Id
	and IsActive = 1
end