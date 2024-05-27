using Cabcast.Core.Common.Model;
using Cabcast.Core.DataEntities.Lookup;

namespace Cabcast.Core.DataAccess.IRepositories
{
    public interface ILookupRepository
    {
        Task<Response<List<VehicleTypeInfoDB>>> GetVehicleTypeInfoList(Guid loggedInUserId);
        Task<Response<List<BookingStatusInfoDB>>> GetBookingStatusInfoList(Guid loggedInUserId);
        Task<Response<List<ColorInfoDB>>> GetColorInfoList(Guid loggedInUserId);
        Task<Response<List<GenderInfoDB>>> GetGenderInfoList(Guid loggedInUserId);
    }
}
