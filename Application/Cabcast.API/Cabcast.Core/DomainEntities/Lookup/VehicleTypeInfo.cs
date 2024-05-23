using Cabcast.Core.Common.Model;

namespace Cabcast.Core.DomainEntities.Lookup
{
    public class VehicleTypeInfo : RowInfo
    {
        public string VehicleType { get; set; } = null!;
        public string VehicleTypeValue { get; set; } = null!;
    }
}
