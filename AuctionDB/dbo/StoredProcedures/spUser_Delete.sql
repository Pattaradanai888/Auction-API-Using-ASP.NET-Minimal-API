CREATE PROCEDURE [dbo].[spUser_Delete]
	@Id int
AS
begin
	update dbo.[User]
	set IsActive = 0
	where Id = @Id
	and IsActive = 1
end
