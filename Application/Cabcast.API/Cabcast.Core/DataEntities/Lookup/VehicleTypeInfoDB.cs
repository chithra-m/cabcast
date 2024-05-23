using Cabcast.Core.Common.Model;

namespace Cabcast.Core.DataEntities.Lookup
{
    public class VehicleTypeInfoDB : RowInfo
    {
        public string VehicleType { get; set; } = null!;
        public string VehicleTypeValue { get; set; } = null!;
    }
}
