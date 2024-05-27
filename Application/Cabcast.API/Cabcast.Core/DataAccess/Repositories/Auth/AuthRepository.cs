using Cabcast.Core.Common.Model;
using Cabcast.Core.DataAccess.IRepositories.Auth;
using Cabcast.Core.DataEntities.Auth;

namespace Cabcast.Core.DataAccess.Repositories.Auth
{
    public class AuthRepository : IAuthRepository
    {
        public async Task<Response<AspNetUserDB>> SaveAspNetUser(Guid loggedInUserId)
        {
            throw new NotImplementedException();
        }
    }
}
