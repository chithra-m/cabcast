using Cabcast.Core.DataEntities.Account;

namespace Cabcast.Core.DataEntities.Setup.Driver
{
    public class DriverInfoDB : UserInfoDB
    {
        public new Guid Id { get; set; }
        public Guid UserInfoId { get; set; }
        public Guid ManagerId { get; set; }
        public string? ManagerFirstName { get; set; }
        public string? ManagerLastName { get; set; }
        public Guid HomeLocationInfoId { get; set; }
        public string HomeLocationInfoName { get; set; } = null!;
        public string HomeLocationInfoAddressLine { get; set; } = null!;
        public Guid HomeLocationInfoSubAreaInfoId { get; set; }
        public string HomeLocationInfoSubAreaInfoName { get; set; } = null!;
        public Guid HomeLocationInfoAreaInfoId { get; set; }
        public string HomeLocationInfoAreaInfoName { get; set; } = null!;
        public string HomeLocationInfoPincode { get; set; } = null!;
    }
}
