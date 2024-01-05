using CarWebApp.API.Entities;
using Microsoft.EntityFrameworkCore;

namespace CarWebApp.API.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions options) : base(options) { }

        public DbSet<CarEntity> CarEntities { get; set; }
    }
}
