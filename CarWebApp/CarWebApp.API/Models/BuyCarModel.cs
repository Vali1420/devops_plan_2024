using System.ComponentModel.DataAnnotations;

namespace CarWebApp.API.Models
{
    public class BuyCarModel
    {
        [Required]
        public string VIN { get; set; }
    }
}
