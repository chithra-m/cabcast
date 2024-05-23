using Cabcast.Core.Common.Constants;
using Cabcast.Core.Common.Model;

namespace Cabcast.Core.Common.Utils
{
    public static class Helpers
    {
        public static bool IsValidGuid(this Guid? id) => id != null && id != Guid.Empty;

        public static bool IsNotValidGuid(this Guid? id) => !IsValidGuid(id);

        public static bool IsValidResponse<T>(Response<T> response) => response != null && response.Data != null && response.IsSuccess;

        public static bool IsValidMonth(int month) => month > 0 && month <= 12;

        // TODO add Minyear & Maxyear for the system in Appsettings
        public static bool IsValidYear(int year) => year > 2020 && year <= 2050;


        #region DateHelpers

        public static bool IsValidDate(this DateTime date) => date >= AppConstants.MIN_DATE && date <= AppConstants.MAX_DATE;
        public static bool IsNotValidDate(this DateTime date) => !IsValidDate(date);

        /// <summary>
        /// Checks if the specified nullable DateTime value is valid.
        /// </summary>
        /// <param name="date">The nullable DateTime value to validate.</param>
        /// <param name="allowNull">Indicates whether null values are considered valid.</param>
        /// <returns>true if the date is valid; otherwise, false.</returns>
        public static bool IsValidDate(this DateTime? date, bool allowNull = true)
        {
            if (!allowNull && date is null)
            {
                return false;
            }

            return date is null || (date >= AppConstants.MIN_DATE && date <= AppConstants.MAX_DATE);
        }

        /// <summary>
        /// Checks if the specified nullable DateTime value is not valid.
        /// </summary>
        /// <param name="date">The nullable DateTime value to validate.</param>
        /// <param name="allowNull">Indicates whether null values are considered valid.</param>
        /// <returns>true if the date is valid; otherwise, false.</returns>
        public static bool IsNotValidDate(this DateTime? date, bool allowNull = true) => !IsValidDate(date);

        public static string ToJavascriptDate(this DateTime date) => date.ToString("yyyy-MM-ddTHH:mm:ss.fffZ");
        public static string ToJavascriptDate(this DateTime? date) => date.HasValue ? date.Value.ToJavascriptDate() : string.Empty;

        #endregion


        #region LoggedInUserHelpers

        public static bool IsInvalidLoggedInUser(this LoggedInUser loggedInUser) => !IsValidGuid(loggedInUser.Id);

        #endregion
    }
}
