using Cabcast.Core.Common.Constants;
using Cabcast.Core.Common.Model;
using Cabcast.Core.Common.Utils;
using Cabcast.Core.DataAccess.IRepositories;
using Cabcast.Core.Operations.IServices;
using Microsoft.Extensions.Logging;

namespace Cabcast.Core.Operations.Services
{
    public class MetadataService(ILogger<MetadataService> logger, IMetadataRepository metadataRepository) : IMetadataService
    {
        public async Task<Response<Guid>> DeleteRecord(Guid id, string tableName, string schemaName, LoggedInUser loggedInUser)
        {
            Response<Guid> response = new Response<Guid>().GetFailedResponse(ResponseConstants.INVALID_PARAM);
            try
            {
                if (loggedInUser.IsInvalidLoggedInUser())
                    return response.GetUnAuthorizeResponse();

                if (!Helpers.IsValidGuid(id))
                    return response.GetInvalidParamResponse();

                if (string.IsNullOrWhiteSpace(schemaName) || string.IsNullOrWhiteSpace(tableName))
                {
                    logger.LogError("Error in MetadataService.DeleteRecord({@id}, {@tableName}, {@schemaName}, {@loggedInUserId}) => schemaName or tableName is invalid", id, tableName, schemaName, loggedInUser.Id);
                    return response.GetInternalServerErrorResponse();
                }

                return await metadataRepository.UpdateRowStatus(id, tableName, schemaName, RowStatusConstants.ROW_STATUS_DELETE, loggedInUser.Id);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error in MetadataService.DeleteRecord({@id}, {@tableName}, {@schemaName}, {@loggedInUserId})", id, tableName, schemaName, loggedInUser.Id);

                return response.GetInternalServerErrorResponse();
            }
        }

        public async Task<Response<Guid>> MakeRecordActive(Guid id, string tableName, string schemaName, LoggedInUser loggedInUser)
        {
            Response<Guid> response = new Response<Guid>().GetFailedResponse(ResponseConstants.INVALID_PARAM);
            try
            {
                if (loggedInUser.IsInvalidLoggedInUser())
                    return response.GetUnAuthorizeResponse();

                if (!Helpers.IsValidGuid(id))
                    return response.GetInvalidParamResponse();

                if (string.IsNullOrWhiteSpace(schemaName) || string.IsNullOrWhiteSpace(tableName))
                {
                    logger.LogError("Error in MetadataService.MakeRecordActive({@id}, {@tableName}, {@schemaName}, {@loggedInUserId}) => schemaName or tableName is invalid", id, tableName, schemaName, loggedInUser.Id);
                    return response.GetInternalServerErrorResponse();
                }

                return await metadataRepository.UpdateRowStatus(id, tableName, schemaName, RowStatusConstants.ROW_STATUS_ACTIVE, loggedInUser.Id);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error in MetadataService.MakeRecordActive({@id}, {@tableName}, {@schemaName}, {@loggedInUserId})", id, tableName, schemaName, loggedInUser.Id);

                return response.GetInternalServerErrorResponse();
            }
        }

        public async Task<Response<Guid>> MakeRecordInActive(Guid id, string tableName, string schemaName, LoggedInUser loggedInUser)
        {
            Response<Guid> response = new Response<Guid>().GetFailedResponse(ResponseConstants.INVALID_PARAM);
            try
            {
                if (loggedInUser.IsInvalidLoggedInUser())
                    return response.GetUnAuthorizeResponse();

                if (!Helpers.IsValidGuid(id))
                    return response.GetInvalidParamResponse();

                if (string.IsNullOrWhiteSpace(schemaName) || string.IsNullOrWhiteSpace(tableName))
                {
                    logger.LogError("Error in MetadataService.MakeRecordInActive({@id}, {@tableName}, {@schemaName}, {@loggedInUserId}) => schemaName or tableName is invalid", id, tableName, schemaName, loggedInUser.Id);
                    return response.GetInternalServerErrorResponse();
                }

                return await metadataRepository.UpdateRowStatus(id, tableName, schemaName, RowStatusConstants.ROW_STATUS_INACTIVE, loggedInUser.Id);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error in MetadataService.MakeRecordInActive({@id}, {@tableName}, {@schemaName}, {@loggedInUserId})", id, tableName, schemaName, loggedInUser.Id);

                return response.GetInternalServerErrorResponse();
            }
        }
    }
}
