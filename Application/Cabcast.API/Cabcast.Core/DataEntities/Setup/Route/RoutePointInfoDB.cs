using Cabcast.Core.Common.Model;

namespace Cabcast.Core.DataEntities.Setup.Route
{
    public class RoutePointInfoDB : BaseInfo
    {
        public Guid Id { get; set; }
        public Guid RouteInfoId { get; set; }
        public int RouteOrderNumber { get; set; }

        public Guid LocationInfoId { get; set; }
        public string LocationInfoName { get; set; } = null!;
        public string LocationInfoAddressLine { get; set; } = null!;
        public Guid LocationInfoSubAreaInfoId { get; set; }
        public string LocationInfoSubAreaInfoName { get; set; } = null!;
        public Guid LocationInfoAreaInfoId { get; set; }
        public string LocationInfoAreaInfoName { get; set; } = null!;
        public string LocationInfoPincode { get; set; } = null!;
    }
}
