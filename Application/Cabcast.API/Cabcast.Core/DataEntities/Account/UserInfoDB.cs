using Cabcast.Core.Common.Model;

namespace Cabcast.Core.DataEntities.Account
{
    public class UserInfoDB : BaseInfo
    {
        public Guid Id { get; set; }
        public string AspNetUserId { get; set; } = null!;
        public string ComcastEmployeeId { get; set; } = null!;
        public string UserName { get; set; } = null!;
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string PhoneNumber { get; set; } = null!;
        public string Gender { get; set; } = null!;
        public string GenderValue { get; set; } = null!;
    }
}
