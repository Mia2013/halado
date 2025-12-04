using FishingShop.Entities;
using Microsoft.EntityFrameworkCore;

namespace FishingShop.Managers
{
    public class ProductManager
    {
        private readonly FishingShopDbContext _context;

        public ProductManager(FishingShopDbContext context)
        {
            _context = context;
        }

        public void Create(Product product)
        {
            _context.Products.Add(product);
            _context.SaveChanges();
        }

        public DbSet<Product> GetAll()
        {
            return _context.Products;
        }


    }
}
