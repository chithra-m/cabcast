using Cabcast.Core.Common.Model;
using Microsoft.AspNetCore.Mvc;

namespace Cabcast.API.Controllers
{
    public class BaseController : Controller
    {
        public BaseController() { }

        private LoggedInUser _LoggedInUserInfo { get; set; }

        public LoggedInUser LoggedInUser
        {
            get
            {

                return new(Guid.Parse("F6510A9A-2E3D-4341-9E94-090ACC25D2A5"));
            }
            set
            {
                _LoggedInUserInfo = value;
            }
        }
    }
}
