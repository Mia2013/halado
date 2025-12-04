namespace FishingShop.Entities
{
    public class Customer
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;

        public ICollection<Order> Orders { get; set; } = new List<Order>();

        public Address Address { get; set; } = new Address()
        {
            Id = 1,
            ZipCode = 8200,
            City = "Veszprém",
            Street = "Egyetem u. 10."
        };
        public override string ToString() => $"{Name} {Email}";
    }
}