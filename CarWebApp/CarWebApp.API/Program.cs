using CarWebApp.API.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

IConfigurationRoot configuration = null;

if (builder.Environment.IsDevelopment())
{
    configuration = new ConfigurationBuilder()
        .AddJsonFile("appsettings.json")
        .AddJsonFile("appsettings.Secrets.json")
        .AddEnvironmentVariables()
        .Build();
}

if (builder.Environment.IsProduction())
{
    configuration = new ConfigurationBuilder()
        .AddJsonFile("appsettings.json")
        .AddEnvironmentVariables()
        .Build();
}

if (configuration != null)
{
    builder.Configuration.AddConfiguration(configuration);

    Console.WriteLine("Preparing the connection with DB..............");

    builder.Services.AddDbContext<DataContext>(options => options.UseNpgsql(configuration["PostgreSql"]));

    builder.Services.AddControllers();
    builder.Services.AddEndpointsApiExplorer();
    builder.Services.AddSwaggerGen();

    var app = builder.Build();

    using (var scope = app.Services.CreateScope())
    {
        var dbContext = scope.ServiceProvider.GetRequiredService<DataContext>();

        dbContext.Database.Migrate();
    }

    app.UseSwagger();
    app.UseSwaggerUI();

    app.UseAuthorization();
    app.MapControllers();
    app.Run();
}