using FishingShop.Entities;
using Microsoft.EntityFrameworkCore;

namespace FishingShop.Managers
{
    public class CustomerManager
    {
        private readonly FishingShopDbContext _context;

        public CustomerManager(FishingShopDbContext context)
        {
            _context = context;
        }

        public void Create(Customer customer)
        {
            _context.Customers.Add(customer);
            _context.SaveChanges();

        }

        public DbSet<Customer> GetAll()
        {
            return _context.Customers;
        }
    }
}
