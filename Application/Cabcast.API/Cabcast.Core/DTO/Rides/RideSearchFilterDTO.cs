namespace Cabcast.Core.DTO.Rides
{
    public record RideSearchFilterDTO(Guid PickupLocationInfoId, Guid DropLocationInfoId, DateOnly RideDate, string VehicleType, bool IsWomenOnly);
}
