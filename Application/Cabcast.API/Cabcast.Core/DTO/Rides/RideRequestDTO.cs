namespace Cabcast.Core.DTO.Rides
{
    public record RideRequestDTO(Guid RideInfoId, Guid PickUpLocationInfoId, Guid PassengerInfoId, DateTime BookingDate);
}
