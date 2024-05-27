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
        
        public static BookingStatusInfo ToBookingStatusInfo(this BookingStatusInfoDB bookingStatus)
        {
            ArgumentNullException.ThrowIfNull($"${nameof(bookingStatus)}  is null in ${nameof(ToBookingStatusInfo)} method on ${nameof(LookupMappers)}");

            return new()
            {
                BookingStatus = bookingStatus.BookingStatus,
                BookingStatusValue = bookingStatus.BookingStatusValue,
                SequenceId = bookingStatus.SequenceId,
                RowStatus = bookingStatus.RowStatus
            };
        }

        public static List<BookingStatusInfo> ToBookingStatusInfoList(this List<BookingStatusInfoDB> bookingStatus)
        {
            ArgumentNullException.ThrowIfNull($"${nameof(bookingStatus)}  is null in ${nameof(ToBookingStatusInfoList)} method on ${nameof(LookupMappers)}");

            return bookingStatus.Select(bookingStatusInfo => bookingStatusInfo.ToBookingStatusInfo()).ToList();
        }

        public static ColorInfo ToColorInfo(this ColorInfoDB color)
        {
            ArgumentNullException.ThrowIfNull($"${nameof(color)}  is null in ${nameof(ToColorInfo)} method on ${nameof(LookupMappers)}");

            return new()
            {
                Color = color.Color,
                ColorValue = color.ColorValue,
                SequenceId = color.SequenceId,
                RowStatus = color.RowStatus
            };
        }

        public static List<ColorInfo> ToColorInfoList(this List<ColorInfoDB> color)
        {
            ArgumentNullException.ThrowIfNull($"${nameof(color)}  is null in ${nameof(ToColorInfoList)} method on ${nameof(LookupMappers)}");

            return color.Select(colorInfo => colorInfo.ToColorInfo()).ToList();
        }

        public static GenderInfo ToGenderInfo(this GenderInfoDB gender)
        {
            ArgumentNullException.ThrowIfNull($"${nameof(gender)}  is null in ${nameof(ToGenderInfo)} method on ${nameof(LookupMappers)}");

            return new()
            {
                Gender = gender.Gender,
                GenderValue = gender.GenderValue,
                SequenceId = gender.SequenceId,
                RowStatus = gender.RowStatus
            };
        }

        public static List<GenderInfo> ToGenderInfoList(this List<GenderInfoDB> gender)
        {
            ArgumentNullException.ThrowIfNull($"${nameof(gender)}  is null in ${nameof(ToGenderInfoList)} method on ${nameof(LookupMappers)}");

            return gender.Select(genderInfo => genderInfo.ToGenderInfo()).ToList();
        }
    }
}
