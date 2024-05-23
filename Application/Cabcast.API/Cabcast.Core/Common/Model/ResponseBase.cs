using Cabcast.Core.Common.Enum;

namespace Cabcast.Core.Common.Model
{
    public class ResponseBase
    {
        public bool IsSuccess { get; set; }

        public bool IsFailure => !IsSuccess;

        public ResultTypeEnum StatusCode { get; set; }

        public string? Message { get; set; }

        public List<string> ValidationErrorMessages { get; set; } = [];

        public bool HasValidationErrorMessages => ValidationErrorMessages.Count > 0;
    }
}
