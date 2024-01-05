using System.ComponentModel.DataAnnotations;

namespace CarWebApp.API.Entities
{
    public class CarEntity
    {
        [Key]
        public string VIN { get; set; }
        public string Name { get; set; }
        public int Price { get; set; }
        public bool Available { get; set; }
    }
}
