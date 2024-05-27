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

        public async Task<Response<List<BookingStatusInfo>>> GetBookingStatusInfoList(LoggedInUser loggedInUser)
        {
            const string currentMethodName = "GetBookingStatusInfoList";
            Response<List<BookingStatusInfo>> response = Response<List<BookingStatusInfo>>.Failed;

            try
            {
                if (loggedInUser.IsInvalidLoggedInUser())
                    return Response<List<BookingStatusInfo>>.UnAuthorizeResponse;

                var dbResponse = await _lookupRepository.GetBookingStatusInfoList(loggedInUser.Id);
                if (Helpers.IsValidResponse(dbResponse))
                {
                    response.Data = dbResponse.Data.ToBookingStatusInfoList();
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

        public async Task<Response<List<ColorInfo>>> GetColorInfoList(LoggedInUser loggedInUser)
        {
            const string currentMethodName = "GetColorInfoList";
            Response<List<ColorInfo>> response = Response<List<ColorInfo>>.Failed;

            try
            {
                if (loggedInUser.IsInvalidLoggedInUser())
                    return Response<List<ColorInfo>>.UnAuthorizeResponse;

                var dbResponse = await _lookupRepository.GetColorInfoList(loggedInUser.Id);
                if (Helpers.IsValidResponse(dbResponse))
                {
                    response.Data = dbResponse.Data.ToColorInfoList();
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

        public async Task<Response<List<GenderInfo>>> GetGenderInfoList(LoggedInUser loggedInUser)
        {
            const string currentMethodName = "GetGenderInfoList";
            Response<List<GenderInfo>> response = Response<List<GenderInfo>>.Failed;

            try
            {
                if (loggedInUser.IsInvalidLoggedInUser())
                    return Response<List<GenderInfo>>.UnAuthorizeResponse;

                var dbResponse = await _lookupRepository.GetGenderInfoList(loggedInUser.Id);
                if (Helpers.IsValidResponse(dbResponse))
                {
                    response.Data = dbResponse.Data.ToGenderInfoList();
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
