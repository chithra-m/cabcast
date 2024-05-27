using Cabcast.Core.DomainEntities.Rides;
using Cabcast.Core.DTO.Rides;
using Microsoft.AspNetCore.Mvc;

namespace Cabcast.API.Controllers.RideBookings
{
    public class RideBookingController(ILogger<RideBookingController> _logger) : BaseController
    {
        [HttpGet, Route("~/ride/booking/passenger/{passengerId:Guid}")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<RideBookingInfo>))]
        public async Task<IActionResult> GetRideBookingByPassengerId(Guid passengerId)
        {
            try
            {
                return Ok(new List<RideBookingInfo>());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in RideBookingController.GetRideBookingByPassengerId({@passengerId})", Convert.ToString(passengerId));
            }

            return BadRequest(ModelState);
        }

        [HttpGet, Route("~/ride/booking/{bookingId:Guid}/")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(RideBookingInfo))]
        public async Task<IActionResult> GetRideBookingById(Guid bookingId)
        {
            try
            {
                return Ok(new RideBookingInfo());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in RideBookingController.GetRideBookingById({@bookingId})", Convert.ToString(bookingId));
            }

            return BadRequest(ModelState);
        }

        [HttpPost, Route("~/ride/booking/request/passenger/{passengerId:Guid}")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(Guid))]
        public async Task<IActionResult> RequestRideBookingByPassengerId(Guid passengerId, [FromBody] RideRequestDTO rideRequest)
        {
            try
            {
                return Ok(Guid.NewGuid());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in RideBookingController.RequestRideBookingByPassengerId({@passengerId}, {@rideRequest})", Convert.ToString(passengerId), Convert.ToString(rideRequest));
            }

            return BadRequest(ModelState);
        }

        [HttpPut, Route("~/ride/booking/{bookingId:Guid}/cancel/passenger/{passengerId:Guid}")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(Guid))]
        public async Task<IActionResult> CancelRideBookingByPassengerId(Guid bookingId, Guid passengerId)
        {
            try
            {
                return Ok(Guid.NewGuid());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in RideBookingController.ManageRideBookingByDriverId({@bookingId}, {@passengerId})"
                    , Convert.ToString(bookingId), Convert.ToString(passengerId));
            }

            return BadRequest(ModelState);
        }

        [HttpPut, Route("~/ride/booking/manage/driver/{driverId:Guid}")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(Guid))]
        public async Task<IActionResult> ManageRideBookingByDriverId(Guid driverId, [FromBody] ManageRideRequestDTO manageRideRequest)
        {
            try
            {
                return Ok(Guid.NewGuid());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in RideBookingController.ManageRideBookingByDriverId({@driverId}, {@manageRideRequest})"
                    , Convert.ToString(driverId), Convert.ToString(manageRideRequest));
            }

            return BadRequest(ModelState);
        }

        [HttpGet, Route("~/ride/booking/passenger/confirmed/{passengerId:Guid}")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<RideBookingInfo>))]
        public async Task<IActionResult> GetConfirmedRideBookingInfoListByPassengerId(Guid passengerId)
        {
            try
            {
                return Ok(new List<RideBookingInfo>());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in RideBookingController.GetConfirmedRideBookingInfoListByPassengerId({@passengerId})", Convert.ToString(passengerId));
            }

            return BadRequest(ModelState);
        }

        [HttpGet, Route("~/ride/booking/driver/{driverId:Guid}")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(List<RideBookingInfo>))]
        public async Task<IActionResult> GetTodayBookingInfoListByDriverId(Guid driverId)
        {
            try
            {
                return Ok(new List<RideBookingInfo>());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in RideBookingController.GetConfirmedRideBookingInfoListByDriverId({@driverId})", Convert.ToString(driverId));
            }

            return BadRequest(ModelState);
        }
    }

}
