CREATE PROCEDURE [dbo].[spUser_GetAll]
AS
begin
	select Id, FullName, Email, CreatedAt 
	from dbo.[User]
	where IsActive = 1
end
