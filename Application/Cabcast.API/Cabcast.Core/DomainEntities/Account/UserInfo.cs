using System.Diagnostics;

namespace Cabcast.Core.DomainEntities.Account
{
    [DebuggerDisplay("User Id : {Id}, UserName : {UserName}, FirstName : {FirstName}")]
    public class UserInfo : UserBaseInfo
    {        
        public string Email { get; set; } = null!;

        public string? PhoneNumber { get; set; }

        public string Gender { get; set; } = null!;

        public bool IsRider { get; set; }

        public UserBaseInfo ManagerInfo { get; set; } = null!;
    }
}
