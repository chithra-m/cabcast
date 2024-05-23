using Cabcast.Core.Common.Constants;
using Cabcast.Core.Common.Model;
using Cabcast.Core.DataAccess.ConnectionManager;
using Cabcast.Core.DataAccess.IRepositories;
using Cabcast.Core.DataAccess.Utils;
using Cabcast.Core.DataEntities.Lookup;
using Dapper;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cabcast.Core.DataAccess.Repositories
{
    public class LookupRepository(ILogger<LookupRepository> _logger, IDataBaseConnection _db) : ILookupRepository
    {
        public async Task<Response<List<VehicleTypeInfoDB>>> GetVehicleTypeInfoList(Guid loggedInUserId)
        {
            Response<List<VehicleTypeInfoDB>> response = Response<List<VehicleTypeInfoDB>>.NotFound;

            try
            {
                string spName = DatabaseConstants.USP_VEHICLE_TYPE_INFO_GET;
                var param = new { LoggedInUserId = loggedInUserId };

                var result = await _db.Connection.QueryAsync<VehicleTypeInfoDB>(spName, param, commandType: CommandType.StoredProcedure);
                return result != null && result.Any()
                    ? response.GetSuccessResponse(result.ToList())
                    : response;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in BaseRepository.GetVehicleTypeInfoList({@loggedInUserId})", loggedInUserId);
                response = response.GetFailedResponse(ResponseConstants.INTERNAL_SERVER_ERROR);
                return response;
            }
        }
    }
}
