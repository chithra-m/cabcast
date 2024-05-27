using Cabcast.Core.DomainEntities.Location;
using Cabcast.Core.DomainEntities.Setup.Driver;

namespace Cabcast.Core.DomainEntities.Rides
{
    public class RideInfo
    {
        public Guid Id { get; set; }
        public DateOnly RideDate { get; set; }
        public TimeOnly StartTime { get; set; }
        public TimeOnly EndTime { get; set; }
        public DriverInfo DriverInfo { get; set; } = new();
        public LocationInfo StartLocation { get; set; } = null!;
        public LocationInfo EndLocation { get; set; } = null!;
        public int AvailableSeats { get; set; }
        public bool IsWomenOnly { get; set; }
    }
}
