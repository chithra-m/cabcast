using Cabcast.Core.Common.Constants;
using Cabcast.Core.Common.Model;
using Cabcast.Core.DataAccess.ConnectionManager;
using Cabcast.Core.DataAccess.IRepositories;
using Cabcast.Core.DataAccess.Utils;
using Cabcast.Core.DataEntities.Lookup;
using Dapper;
using Microsoft.Extensions.Logging;
using System.Data;

namespace Cabcast.Core.DataAccess.Repositories
{
    public class LookupRepository(ILogger<LookupRepository> _logger, IDataBaseConnection _db) : ILookupRepository
    {
        public async Task<Response<List<BookingStatusInfoDB>>> GetBookingStatusInfoList(Guid loggedInUserId)
        {
            Response<List<BookingStatusInfoDB>> response = Response<List<BookingStatusInfoDB>>.NotFound;

            try
            {
                string spName = DatabaseConstants.USP_BOOKING_STATUS_INFO_GET;
                var param = new { LoggedInUserId = loggedInUserId };

                var result = await _db.Connection.QueryAsync<BookingStatusInfoDB>(spName, param, commandType: CommandType.StoredProcedure);
                return result != null && result.Any()
                    ? response.GetSuccessResponse(result.ToList())
                    : response;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in LookupRepository.GetBookingStatusInfoDBList({@loggedInUserId})", loggedInUserId);
                response = response.GetFailedResponse(ResponseConstants.INTERNAL_SERVER_ERROR);
                return response;
            }
        }

        public async Task<Response<List<ColorInfoDB>>> GetColorInfoList(Guid loggedInUserId)
        {
            Response<List<ColorInfoDB>> response = Response<List<ColorInfoDB>>.NotFound;

            try
            {
                string spName = DatabaseConstants.USP_COLOR_INFO_GET;
                var param = new { LoggedInUserId = loggedInUserId };

                var result = await _db.Connection.QueryAsync<ColorInfoDB>(spName, param, commandType: CommandType.StoredProcedure);
                return result != null && result.Any()
                    ? response.GetSuccessResponse(result.ToList())
                    : response;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in LookupRepository.GetColorInfoDBList({@loggedInUserId})", loggedInUserId);
                response = response.GetFailedResponse(ResponseConstants.INTERNAL_SERVER_ERROR);
                return response;
            }
        }

        public async Task<Response<List<GenderInfoDB>>> GetGenderInfoList(Guid loggedInUserId)
        {
            Response<List<GenderInfoDB>> response = Response<List<GenderInfoDB>>.NotFound;

            try
            {
                string spName = DatabaseConstants.USP_GENDER_INFO_GET;
                var param = new { LoggedInUserId = loggedInUserId };

                var result = await _db.Connection.QueryAsync<GenderInfoDB>(spName, param, commandType: CommandType.StoredProcedure);
                return result != null && result.Any()
                    ? response.GetSuccessResponse(result.ToList())
                    : response;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in LookupRepository.GetGenderInfoDBList({@loggedInUserId})", loggedInUserId);
                response = response.GetFailedResponse(ResponseConstants.INTERNAL_SERVER_ERROR);
                return response;
            }
        }

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
                _logger.LogError(ex, "Error in LookupRepository.GetVehicleTypeInfoList({@loggedInUserId})", loggedInUserId);
                response = response.GetFailedResponse(ResponseConstants.INTERNAL_SERVER_ERROR);
                return response;
            }
        }
    }
}
