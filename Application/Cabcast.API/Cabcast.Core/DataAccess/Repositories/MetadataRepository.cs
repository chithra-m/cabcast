using Cabcast.Core.Common.Constants;
using Cabcast.Core.Common.Model;
using Cabcast.Core.Common.Utils;
using Cabcast.Core.DataAccess.ConnectionManager;
using Cabcast.Core.DataAccess.IRepositories;
using Cabcast.Core.DataAccess.Utils;
using Dapper;
using Microsoft.Extensions.Logging;
using System.Data;

namespace Cabcast.Core.DataAccess.Repositories
{
    public class MetadataRepository : IMetadataRepository
    {
        private readonly ILogger<MetadataRepository> _logger;
        private readonly IDataBaseConnection _db;

        public MetadataRepository(ILogger<MetadataRepository> logger, IDataBaseConnection db)
        {
            _logger = logger;
            _db = db;
        }

        public async Task<Response<Guid>> UpdateRowStatus(Guid id, string tableName, string schemaName, char rowStatus, Guid loggedInUserId)
        {
            Response<Guid> response = Response<Guid>.Failed;

            try
            {
                var spName = DatabaseConstants.USP_ROW_STATUS_UPDATE;
                DynamicParameters _params = new DynamicParameters();
                _params.Add("@Id", id, DbType.Guid);
                _params.Add("@TableSchema", schemaName, DbType.String);
                _params.Add("@TableName", tableName, DbType.String);
                _params.Add("@RowStatus", rowStatus, DbType.String);
                _params.Add("@LoggedInUser", loggedInUserId, DbType.Guid);
                _params.Add("@Result", null, DbType.Guid, direction: ParameterDirection.Output);
                var returnValue = await _db.Connection.QueryAsync<Guid>(spName, _params, commandType: CommandType.StoredProcedure);
                var result = _params.Get<Guid>("@Result");

                return returnValue != null && Helpers.IsValidGuid(result)
                    ? response.GetSuccessResponse(result)
                    : response;
            }
            catch (Exception ex)
            {

                _logger.LogError(ex, "Error in MetadataRepository.UpdateRowStatus({@id}, {@tableName}, {@schemaName}, {@rowStatus}, {@loggedInUserId})", id, tableName, schemaName, rowStatus, loggedInUserId);

                response.Message = ex.Message switch
                {
                    "INVALID_PARAM_LOGGED_IN_USER" => ResponseConstants.INVALID_LOGGED_IN_USER,
                    "INVALID_PARAM_ID" => ResponseConstants.INVALID_ID,
                    "INVALID_PARAM_TABLE_NAME" => ResponseConstants.INVALID_PARAM_TABLE_NAME,
                    "INVALID_PARAM_ROW_STATUS" => ResponseConstants.INVALID_PARAM_ROW_STATUS,
                    _ => ResponseConstants.SOMETHING_WENT_WRONG
                };

                return response;
            }
        }
    }
}
