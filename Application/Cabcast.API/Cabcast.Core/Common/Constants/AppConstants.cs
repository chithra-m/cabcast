namespace Cabcast.Core.Common.Constants
{
    public static class AppConstants
    {
        public const int STRING_MIN_LENGTH = 2;

        #region Date Constants

        public static readonly DateTime MIN_DATE = new(2020, 1, 1);
        public static readonly DateTime MAX_DATE = new(2050, 1, 1);

        #endregion

        #region SchemaName

        public static readonly string SCHEMA_SETUP = "Setup";

        #endregion

        #region TableName

        #endregion
    }
}
