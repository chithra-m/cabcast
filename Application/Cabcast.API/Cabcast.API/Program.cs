using Cabcast.API.IoC;

namespace Cabcast.API
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
            using IHost host = Host.CreateDefaultBuilder(args).Build();
            IConfiguration config = host.Services.GetRequiredService<IConfiguration>();
            string connectionString = config["ConnectionStrings:DefaultConnection"] ?? throw new ArgumentNullException("ConnectionStrings:DefaultConnection is null");

            builder.Services.InjectDependencies(connectionString);

            builder.Services.AddControllers();
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }
            app.UseHttpsRedirection();

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}
