using Cabcast.Core.Common.Model;

namespace Cabcast.Core.DataEntities.Account
{
    public class UserBaseInfoDB : BaseInfo
    {
        public Guid Id { get; set; }
        public string AspNetUserId { get; set; } = null!;
        public string ComcastEmployeeId { get; set; } = null!;
        public string UserName { get; set; } = null!;
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
    }
}
