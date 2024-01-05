using System.ComponentModel.DataAnnotations;

namespace CarBillingApp.API.Entities
{
    public class BillingEntity
    {
        [Key]
        public string CustomerId { get; set; }
        [Key]
        public string VIN { get; set; }
        public DateTime PurchaseDateTime { get; set; }
        public string CustomerInformations { get; set; }
    }
}
