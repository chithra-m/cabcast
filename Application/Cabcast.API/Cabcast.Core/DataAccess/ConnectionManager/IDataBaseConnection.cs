using System.Data;

namespace Cabcast.Core.DataAccess.ConnectionManager
{
    public interface IDataBaseConnection
    {
        IDbConnection Connection { get; }
    }
}
