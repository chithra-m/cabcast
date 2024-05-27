using Cabcast.Core.DataEntities.Account;

namespace Cabcast.Core.DataEntities.Setup.Passenger
{
    public class PassengerInfoDB : UserInfoDB
    {
        public new Guid Id { get; set; }
        public Guid UserInfoId { get; set; }
        public TimeOnly DepartureTime { get; set; }
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
