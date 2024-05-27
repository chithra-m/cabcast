using Cabcast.Core.Common.Model;
using Cabcast.Core.DataEntities.Location;
using Cabcast.Core.DataEntities.Lookup;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cabcast.Core.DataAccess.IRepositories.Location
{
    public interface ILocationRepository
    {
        Task<Response<List<AreaInfoDB>>> GetAreaInfoList(Guid loggedInUserId);
        Task<Response<List<LocationInfoDB>>> GetLocationInfoList(Guid loggedInUserId);
        Task<Response<List<SubAreaInfoDB>>> GetSubAreaInfoList(Guid loggedInUserId);
        
    }
}
