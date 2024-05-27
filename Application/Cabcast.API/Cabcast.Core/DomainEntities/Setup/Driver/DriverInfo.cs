using Cabcast.Core.DomainEntities.Account;
using Cabcast.Core.DomainEntities.Location;

namespace Cabcast.Core.DomainEntities.Setup.Driver
{
    public class DriverInfo : UserInfo
    {
        public new Guid Id { get; set; }
        public Guid UserInfoId { get; set; }
        public LocationInfo HomeLocationInfo { get; set; } = null!;
        public DriverVehicleInfo VehicleInfo { get; set; } = null!;
    }
}
