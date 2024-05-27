using Cabcast.Core.Common.Model;
using Cabcast.Core.DomainEntities.Location;
using Cabcast.Core.DomainEntities.Lookup;
using Cabcast.Core.DomainEntities.Setup.Passenger;

namespace Cabcast.Core.DomainEntities.Rides
{
    public class RideBookingInfo : BaseInfo
    {
        public Guid Id { get; set; }
        public double Price { get; set; }
        public DateTime BookingDate { get; set; }
        public RideInfo RideInfo { get; set; } = null!;
        public BookingStatusInfo BookingStatusInfo { get; set; } = null!;
        public PassengerInfo PassengerInfo { get; set; } = null!;
        public LocationInfo PickupLocationInfo { get; set; } = null!;
    }
}
