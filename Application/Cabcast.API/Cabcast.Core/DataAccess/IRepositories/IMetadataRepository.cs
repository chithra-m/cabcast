using Cabcast.Core.Common.Model;

namespace Cabcast.Core.DataAccess.IRepositories
{
    public interface IMetadataRepository
    {
        Task<Response<Guid>> UpdateRowStatus(Guid id, string tableName, string schemaName, char rowStatus, Guid loggedInUserId);
    }
}
