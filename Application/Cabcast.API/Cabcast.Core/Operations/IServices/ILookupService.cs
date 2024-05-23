using Cabcast.Core.Common.Model;
using Cabcast.Core.DomainEntities.Lookup;

namespace Cabcast.Core.Operations.IServices
{
    public interface ILookupService
    {
        Task<Response<List<VehicleTypeInfo>>> GetVehicleTypeInfoList(LoggedInUser loggedInUser);
    }
}
