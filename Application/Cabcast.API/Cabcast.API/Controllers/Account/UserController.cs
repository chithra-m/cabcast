using Cabcast.Core.DTO.Account;
using Cabcast.Core.DTO.Auth;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace Cabcast.API.Controllers.Account
{
    public class UserController(
        UserManager<IdentityUser> _userManager,
        SignInManager<IdentityUser> _signInManager,
        ILogger<UserController> logger) : Controller
    {
        [HttpPost, Route("~/user/register")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(Guid))]
        public async Task<IActionResult> RegisterUser([FromBody] RegisterUserDTO model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var user = new IdentityUser { UserName = model.UserName, Email = model.Email };
                    IdentityResult result = await _userManager.CreateAsync(user, model.Password);

                    if (result.Succeeded)
                    {
                        return Ok(Guid.NewGuid());
                    }

                    return BadRequest(result.Errors);
                }
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error in UserController.RegisterUser({@model})", Convert.ToString(model));
            }

            return BadRequest(ModelState);
        }

        [HttpPost, Route("~/user/login")]
        public async Task<IActionResult> Login([FromBody] LoginUserDTO model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var result = await _signInManager.PasswordSignInAsync(model.UserName, model.Password, isPersistent: false, lockoutOnFailure: false);

                    if (result.Succeeded)
                    {
                        return Ok(new { message = "Login successful!" });
                    }

                    return Unauthorized(new { message = "Invalid login attempt." });
                }

                return BadRequest(ModelState);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error in UserController.RegisterUser({@model})", Convert.ToString(model));
            }

            return BadRequest(ModelState);
        }
    }
}
