namespace Cabcast.Core.DataEntities.Account
{
    public class UserInfoDB : UserBaseInfoDB
    {
        public string Email { get; set; } = null!;
        public string PhoneNumber { get; set; } = null!;
        public string Gender { get; set; } = null!;
        public string GenderValue { get; set; } = null!;
    }
}
