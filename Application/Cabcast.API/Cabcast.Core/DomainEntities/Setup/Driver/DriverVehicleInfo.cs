using Cabcast.Core.Common.Model;
using Cabcast.Core.DomainEntities.Lookup;

namespace Cabcast.Core.DomainEntities.Setup.Driver
{
    public class DriverVehicleInfo : BaseInfo
    {
        public Guid Id { get; set; }
        public Guid DriverInfoId { get; set; }
        public VehicleTypeInfo VehicleType { get; set; } = new();
        public string VehicleNumber { get; set; } = null!;
        public string VehicleColor { get; set; } = null!;
        public int MaximumSeats { get; set; }
        public bool IsSupportsAC { get; set; }
    }
}
