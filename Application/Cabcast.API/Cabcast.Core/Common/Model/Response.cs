using Cabcast.Core.Common.Constants;
using Cabcast.Core.Common.Enum;

namespace Cabcast.Core.Common.Model
{
    public class Response<T> : ResponseBase
    {
        public T Data { get; set; }

        public static Response<T> Success => new() { StatusCode = ResultTypeEnum.Success, IsSuccess = true, Message = ResponseConstants.SUCCESS };

        public static Response<T> Failed => new() { StatusCode = ResultTypeEnum.Failed, Message = ResponseConstants.FAILED };

        public static Response<T> NotFound => new() { StatusCode = ResultTypeEnum.NotFound, Message = ResponseConstants.NO_RECORDS_FOUND };

        public static Response<T> UnAuthorizeResponse => new() { StatusCode = ResultTypeEnum.NotAuthorized, Message = ResponseConstants.INVALID_LOGGED_IN_USER };

        public static Response<T> InvalidParamResponse => new() { StatusCode = ResultTypeEnum.InvalidParam, Message = ResponseConstants.INVALID_PARAM };

        public static Response<T> InternalServerErrorResponse => new() { StatusCode = ResultTypeEnum.Failed, Message = ResponseConstants.INTERNAL_SERVER_ERROR };

        public Response<T> GetInternalServerErrorResponse() => InternalServerErrorResponse;

        public Response<T> GetUnAuthorizeResponse() => UnAuthorizeResponse;

        public Response<T> GetInvalidParamResponse() => InvalidParamResponse;

        public Response<T> GetFailedResponse(string? errorMessage = null) => new() { StatusCode = ResultTypeEnum.Failed, Message = errorMessage ?? ResponseConstants.FAILED };

        public Response<T> GetValidationFailedResponse(List<string>? validationErrors = null) => new() { StatusCode = ResultTypeEnum.ValidationError, Message = ResponseConstants.VALIDATION_FAILED, ValidationErrorMessages = validationErrors ?? ValidationErrorMessages };

        public Response<T> GetSuccessResponse(T data) => new() { Data = data, StatusCode = ResultTypeEnum.Success, IsSuccess = true, Message = ResponseConstants.SUCCESS };
    }
}
