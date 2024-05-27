namespace Cabcast.Core.DataEntities.Auth
{
    public class AspNetUserDB
    {
        public string Id { get; set; } = null!;
        public string UserName { get; set; } = null!;
        public string NormalizedUserName { get; set; } = null!;
        public string PasswordHash { get; set; } = null!;
        public string SecurityStamp { get; set; } = null!;
        public string ConcurrencyStamp { get; set; } = null!;
        public bool TwoFactorEnabled { get; set; }
        public DateTimeOffset? LockoutEnd { get; set; }
        public bool LockoutEnabled { get; set; }
        public int AccessFailedCount { get; set; }
    }
}
