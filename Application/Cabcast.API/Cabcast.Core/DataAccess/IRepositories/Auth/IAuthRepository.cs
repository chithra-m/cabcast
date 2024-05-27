using Cabcast.Core.Common.Model;
using Cabcast.Core.DataEntities.Auth;

namespace Cabcast.Core.DataAccess.IRepositories.Auth
{
    public interface IAuthRepository
    {
        Task<Response<AspNetUserDB>> SaveAspNetUser(Guid loggedInUserId);
    }
}
