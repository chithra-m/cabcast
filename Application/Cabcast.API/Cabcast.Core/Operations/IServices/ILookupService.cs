using Cabcast.Core.Common.Model;
using Cabcast.Core.DomainEntities.Lookup;

namespace Cabcast.Core.Operations.IServices
{
    public interface ILookupService
    {
        Task<Response<List<VehicleTypeInfo>>> GetVehicleTypeInfoList(LoggedInUser loggedInUser);
        Task<Response<List<BookingStatusInfo>>> GetBookingStatusInfoList(LoggedInUser loggedInUser);
        Task<Response<List<GenderInfo>>> GetGenderInfoList(LoggedInUser loggedInUser);
        Task<Response<List<ColorInfo>>> GetColorInfoList(LoggedInUser loggedInUser);
    }
}
