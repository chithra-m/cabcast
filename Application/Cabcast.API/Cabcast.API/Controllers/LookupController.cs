using Cabcast.Core.Common.Model;
using Cabcast.Core.Common.Utils;
using Cabcast.Core.DomainEntities.Lookup;
using Cabcast.Core.Operations.IServices;
using Microsoft.AspNetCore.Mvc;

namespace Cabcast.API.Controllers
{
    public class LookupController(ILogger<LookupController> _logger, ILookupService _lookupService) : BaseController
    {
        [HttpGet, Route("~/lookup/vehicle-type")]
        public async Task<IActionResult> GetVehicleTypeInfoList()
        {
            Response<List<VehicleTypeInfo>> response = Response<List<VehicleTypeInfo>>.Failed;

            try
            {
                if (LoggedInUser.IsInvalidLoggedInUser())
                    return StatusCode(StatusCodes.Status401Unauthorized, response.GetUnAuthorizeResponse());

                var dbresponse = await _lookupService.GetVehicleTypeInfoList(LoggedInUser);
                return StatusCode(StatusCodes.Status200OK, dbresponse ?? response.GetFailedResponse());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in LookupController.GetVehicleTypeInfoList({@loggedInUserId})", LoggedInUser);
                return StatusCode(StatusCodes.Status500InternalServerError, response.GetInternalServerErrorResponse());
            }
        }
    }
}
