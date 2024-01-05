using CarBillingApp.API.Data;
using CarBillingApp.API.Entities;
using CarBillingApp.API.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace CarBillingApp.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CarBillingController : ControllerBase
    {
        private DataContext _dataContext;

        public CarBillingController(DataContext dataContext)
        {
            _dataContext = dataContext;
        }

        [HttpPost]
        [Route("addBill")]
        public async Task<IActionResult> AddBill([FromBody] AddBillModel addBillModel)
        {
            var bill = await _dataContext.BillingEntity.FindAsync(addBillModel.CustomerId, addBillModel.VIN);

            if (bill != null)
            {
                throw new Exception("Bill already exists!");
            }

            await _dataContext.BillingEntity.AddAsync(new BillingEntity
            {
                CustomerId = addBillModel.CustomerId,
                CustomerInformations = addBillModel.CustomerInformations,
                PurchaseDateTime = DateTime.Now,
                VIN = addBillModel.VIN
            });

            await _dataContext.SaveChangesAsync();

            return Ok(addBillModel.CustomerId);
        }

        [HttpGet]
        [Route("getBills")]
        public async Task<IActionResult> GetBills()
            => Ok(await _dataContext.BillingEntity.ToListAsync());
    }
}
