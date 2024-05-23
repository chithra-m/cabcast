using Cabcast.Core.Common.Model;
using Cabcast.Core.DataEntities.Lookup;

namespace Cabcast.Core.DataAccess.IRepositories
{
    public interface ILookupRepository
    {
        Task<Response<List<VehicleTypeInfoDB>>> GetVehicleTypeInfoList(Guid loggedInUserId);
    }
}
