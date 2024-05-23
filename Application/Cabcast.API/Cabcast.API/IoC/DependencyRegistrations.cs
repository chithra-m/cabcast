using Cabcast.Core.DataAccess.ConnectionManager;
using Cabcast.Core.DataAccess.IRepositories;
using Cabcast.Core.DataAccess.Repositories;
using Cabcast.Core.Operations.IServices;
using Cabcast.Core.Operations.Services;

namespace Cabcast.API.IoC
{
    public static class DependencyRegistrations
    {
        public static void InjectDependencies(this IServiceCollection services, string connectionString)
        {
            // services
            services.AddTransient<IDataBaseConnection, DataBaseConnection>(con => new DataBaseConnection(connectionString));

            services.AddTransient<IMetadataRepository, MetadataRepository>();
            services.AddTransient<IMetadataService, MetadataService>();

            services.AddTransient<ILookupRepository, LookupRepository>();
            services.AddTransient<ILookupService, LookupService>();
        }
    }
}
