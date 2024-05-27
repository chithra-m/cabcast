namespace Cabcast.Core.DTO.Auth
{
    public class RegisterUserDTO
    {
        public Guid Id { get; set; }

        public string ComcastEmployeeId { get; set; } = null!;

        public string UserName { get; set; } = null!;

        public string Password { get; set; } = null!;

        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;

        public string Email { get; set; } = null!;

        public string? PhoneNumber { get; set; }

        public string Gender { get; set; } = null!;

        public Guid? ManagerId { get; set; }

        public bool IsRider { get; set; }
    }
}
