using Cabcast.Core.Common.Model;

namespace Cabcast.Core.DataEntities.Setup.Route
{
    public class RouteInfoDB : BaseInfo
    {
        public Guid Id { get; set; }
        
        public Guid StartLocationInfoId { get; set; }
        public string StartLocationInfoName { get; set; } = null!;
        public string StartLocationInfoAddressLine { get; set; } = null!;
        public Guid StartLocationInfoSubAreaInfoId { get; set; }
        public string StartLocationInfoSubAreaInfoName { get; set; } = null!;
        public Guid StartLocationInfoAreaInfoId { get; set; }
        public string StartLocationInfoAreaInfoName { get; set; } = null!;
        public string StartLocationInfoPincode { get; set; } = null!;

        public Guid EndLocationInfoId { get; set; }
        public string EndLocationInfoName { get; set; } = null!;
        public string EndLocationInfoAddressLine { get; set; } = null!;
        public Guid EndLocationInfoSubAreaInfoId { get; set; }
        public string EndLocationInfoSubAreaInfoName { get; set; } = null!;
        public Guid EndLocationInfoAreaInfoId { get; set; }
        public string EndLocationInfoAreaInfoName { get; set; } = null!;
        public string EndLocationInfoPincode { get; set; } = null!;
    }
}
