using Cabcast.Core.DomainEntities.Rides;
using Cabcast.Core.DTO.Rides;
using Microsoft.AspNetCore.Mvc;

namespace Cabcast.API.Controllers.Rides
{
    public class RideController(ILogger<RideController> _logger) : BaseController
    {
        [HttpGet, Route("~/ride/search")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<RideInfo>))]
        public async Task<IActionResult> SearchRideByFilter(RideSearchFilterDTO searchFilter)
        {
            try
            {
                return Ok(new List<RideInfo>());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in RideController.SearchRideByFilter({@searchFilter})", Convert.ToString(searchFilter));
            }

            return BadRequest(ModelState);
        }

        [HttpPost, Route("~/ride/")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(Guid))]
        public async Task<IActionResult> SaveRide(RideSaveDTO rideSave)
        {
            try
            {
                return Ok(Guid.NewGuid());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in RideController.CreateRide({@rideSave})", Convert.ToString(rideSave));
            }

            return BadRequest(ModelState);
        }

        [HttpPut, Route("~/ride/cancel/{rideInfoId:Guid}")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(Guid))]
        public async Task<IActionResult> CancelRide(Guid rideInfoId)
        {
            try
            {
                return Ok(Guid.NewGuid());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in RideController.CancelRide({@rideInfoId})", Convert.ToString(rideInfoId));
            }

            return BadRequest(ModelState);
        }
    }
}
