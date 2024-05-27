using Cabcast.Core.Common.Model;
using System.Diagnostics;

namespace Cabcast.Core.DomainEntities.Account
{
    [DebuggerDisplay("User Id : {Id}, UserName : {UserName}, FirstName : {FirstName}")]
    public class UserInfo : BaseInfo
    {
        public Guid Id { get; set; }

        public string AspNetUserId { get; set; } = null!;

        public string ComcastEmployeeId { get; set; } = null!;

        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;
        
        public string Email { get; set; } = null!;

        public string? PhoneNumber { get; set; }

        public string Gender { get; set; } = null!;

        public Guid? ManagerId { get; set; }

        public bool IsRider { get; set; }
    }
}
