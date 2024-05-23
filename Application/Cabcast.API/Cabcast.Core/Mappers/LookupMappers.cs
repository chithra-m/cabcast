using Cabcast.Core.DataEntities.Lookup;
using Cabcast.Core.DomainEntities.Lookup;

namespace Cabcast.Core.Mappers
{
    public static class LookupMappers
    {
        public static VehicleTypeInfo ToVehicleTypeInfo(this VehicleTypeInfoDB vehicleType)
        {
            ArgumentNullException.ThrowIfNull($"${nameof(vehicleType)}  is null in ${nameof(ToVehicleTypeInfo)} method on ${nameof(LookupMappers)}");

            return new()
            {
                VehicleType = vehicleType.VehicleType,
                VehicleTypeValue = vehicleType.VehicleTypeValue,
                SequenceId = vehicleType.SequenceId,
                RowStatus = vehicleType.RowStatus
            };
        }

        public static List<VehicleTypeInfo> ToVehicleTypeInfoList(this List<VehicleTypeInfoDB> vehicleType)
        {
            ArgumentNullException.ThrowIfNull($"${nameof(vehicleType)}  is null in ${nameof(ToVehicleTypeInfoList)} method on ${nameof(LookupMappers)}");

            return vehicleType.Select(vehicleTypeInfo => vehicleTypeInfo.ToVehicleTypeInfo()).ToList();
        }
    }
}
