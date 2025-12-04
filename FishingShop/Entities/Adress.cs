namespace FishingShop.Entities
{
    public class Address
    {
        public required int Id { get; set; }
        public required int ZipCode { get; set; }
        public required string City { get; set; } = string.Empty;
        public required string Street { get; set; } = string.Empty;
    }
}
