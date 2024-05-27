using Cabcast.Core.DomainEntities.Setup.Driver;
using Microsoft.AspNetCore.Mvc;

namespace Cabcast.API.Controllers.Setup
{

    public class DriverController(ILogger<DriverController> _logger) : BaseController
    {
        [HttpGet, Route("~/driver/{driverInfoId:Guid}")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(DriverInfo))]
        public async Task<IActionResult> GetDriverInfoId(Guid driverInfoId)
        {
            try
            {
                return Ok(new DriverInfo());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in DriverController.GetDriverInfoId({@driverInfoId})", Convert.ToString(driverInfoId));
            }

            return BadRequest(ModelState);
        }
    }
}
