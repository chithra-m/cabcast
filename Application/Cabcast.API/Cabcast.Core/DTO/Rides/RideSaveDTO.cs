namespace Cabcast.Core.DTO.Rides
{
    public record RideSaveDTO(Guid DriverInfoId, Guid RouteInfoId, DateOnly RideDate, TimeOnly StartTime, TimeOnly EndTime, bool IsWomenOnly);
}
