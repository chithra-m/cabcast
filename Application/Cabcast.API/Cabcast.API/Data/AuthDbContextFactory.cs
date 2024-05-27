using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore;

namespace Cabcast.API.Data
{
    public class AuthDbContextFactory : IDesignTimeDbContextFactory<AuthDbContext>
    {
        public AuthDbContext CreateDbContext(string[] args)
        {
            var optionsBuilder = new DbContextOptionsBuilder<AuthDbContext>();
            optionsBuilder.UseSqlServer("Server=PC;Database=CabcastDB;Trusted_Connection=True;MultipleActiveResultSets=true;TrustServerCertificate=True");

            return new AuthDbContext(optionsBuilder.Options);
        }
    }
}
