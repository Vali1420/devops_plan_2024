using CarWebApp.API.Data;
using CarWebApp.API.Entities;
using CarWebApp.API.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace CarWebApp.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CarWebController : ControllerBase
    {
        public DataContext _dataContext { get; set; }
        private HttpClient _httpClient;
        public string _carbillingURL;

        public CarWebController(
            DataContext dataContext,
            IConfiguration configuration)
        {
            _dataContext = dataContext;
            _carbillingURL = configuration["CarBillingAppURI"];
            _httpClient = new HttpClient();
        }

        [HttpPost]
        [Route("addCar")]
        public async Task<IActionResult> AddCar([FromBody] AddCarModel addCarModel)
        {
            await _dataContext.CarEntities.AddAsync(new CarEntity()
            {
                VIN = addCarModel.VIN,
                Name = addCarModel.Name,
                Price = addCarModel.Price,
                Available = true
            });

            await _dataContext.SaveChangesAsync();

            return Ok($"The car with VIN = {addCarModel.VIN} was added successfully!");
        }

        [HttpPost]
        [Route("buyCar")]
        public async Task<IActionResult> BuyCar([FromQuery] Guid customerId, [FromBody] BuyCarModel buyCarModel)
        {
            var car = await _dataContext.CarEntities.FindAsync(buyCarModel.VIN);

            if (car != null && car.Available)
            {
                _httpClient.BaseAddress = new Uri(_carbillingURL);

                var response = await _httpClient.PostAsJsonAsync("addBill", new
                {
                    customerId = customerId,
                    vin = buyCarModel.VIN,
                    customerInformations = car.Name
                });

                var json = await response.Content.ReadAsStringAsync();

                car.Available = false;

                await _dataContext.SaveChangesAsync();

                return Ok($"Car was sold successfully and the customer ${customerId} received an invoice on his email address.");
            }
            else
            {
                return StatusCode(400, "Car is not available anymore or it doesn't exists!");
            }
        }

        [HttpGet]
        [Route("getCars")]
        public async Task<IActionResult> GetCars()
            => Ok(await _dataContext.CarEntities.ToListAsync());

        [HttpGet]
        [Route("test")]
        public async Task<IActionResult> Test()
        {
            return Ok("Test");
        }
    }
}
