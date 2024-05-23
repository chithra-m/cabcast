using Cabcast.Core.Common.Model;
using Cabcast.Core.Common.Utils;
using Cabcast.Core.DataAccess.IRepositories;
using Cabcast.Core.DomainEntities.Lookup;
using Cabcast.Core.Mappers;
using Cabcast.Core.Operations.IServices;
using Microsoft.Extensions.Logging;

namespace Cabcast.Core.Operations.Services
{
    public class LookupService(ILogger<LookupService> logger, ILookupRepository _lookupRepository) : ILookupService
    {
        public async Task<Response<List<VehicleTypeInfo>>> GetVehicleTypeInfoList(LoggedInUser loggedInUser)
        {
            const string currentMethodName = "GetVehicleTypeInfoList";
            Response<List<VehicleTypeInfo>> response = Response<List<VehicleTypeInfo>>.Failed;

            try
            {
                if (loggedInUser.IsInvalidLoggedInUser())
                    return Response<List<VehicleTypeInfo>>.UnAuthorizeResponse;

                var dbResponse = await _lookupRepository.GetVehicleTypeInfoList(loggedInUser.Id);
                if (Helpers.IsValidResponse(dbResponse))
                {
                    response.Data = dbResponse.Data.ToVehicleTypeInfoList();
                    response = response.GetSuccessResponse(response.Data);
                }

                return response;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error in LookupService.${currentMethodName} with parameters, ${nameof(loggedInUser)} : ${loggedInUser.Id}");
                return response.GetInternalServerErrorResponse();
            }
        }
    }
}
