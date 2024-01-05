using CarBillingApp.API.Entities;
using Microsoft.EntityFrameworkCore;

namespace CarBillingApp.API.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions options) : base(options) { }

        public DbSet<BillingEntity> BillingEntity { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<BillingEntity>().HasKey(e => new { e.CustomerId, e.VIN });
        }
    }
}