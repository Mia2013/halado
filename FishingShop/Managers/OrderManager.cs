using FishingShop.Entities;
using Microsoft.EntityFrameworkCore;

namespace FishingShop.Managers
{
    public class OrderManager
    {
        private readonly FishingShopDbContext _context;

        public OrderManager(FishingShopDbContext context)
        {
            _context = context;
        }

        public List<Order> GetAll()
        {
            return _context.Orders
                .Include(o => o.Customer)
                .OrderBy(o => o.OrderDate)
                .ToList();
        }

        public Dictionary<DateTime, int> GetOrderCountByDate()
        {
            var q = _context.Orders.GroupBy(o => o.OrderDate).ToDictionary(g => g.Key, g => g.Count());
            return q; ;

        }

        public void Create(Order order)
        {
            _context.Orders.Add(order);
            _context.SaveChanges();
        }
    }
}
