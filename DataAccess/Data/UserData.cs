using DataAccess.DbAccess;
using DataAccess.Models;

namespace DataAccess.Data;


public class UserData : IUserData
{
    private readonly ISqlDataAccess _db;

    public UserData(ISqlDataAccess db)
    {
        _db = db;
    }

    public Task<IEnumerable<UserModel>> GetUsers() =>
        _db.LoadData<UserModel, dynamic>("dbo.spUser_GetAll", new { });

    public Task<UserModel?> GetUserById(int id) =>
        _db.LoadData<UserModel, dynamic>("dbo.spUser_GetById", new { Id = id })
        .ContinueWith(t => t.Result.FirstOrDefault());

    public Task InsertUser(UserModel user) =>
        _db.SaveData("dbo.spUser_Insert", new
        {
            user.FullName,
            user.Email,
            user.CreatedAt,
            user.IsActive
        });

    public Task UpdateUser(UserModel user) =>
        _db.SaveData("dbo.spUser_Update", user);

    public Task DeleteUser(int id) =>
        _db.SaveData("dbo.spUser_Delete", new { Id = id });
}
