using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cabcast.Core.DataAccess.Utils
{
    public static class DatabaseConstants
    {
        #region Metadata

        public const string USP_ROW_STATUS_UPDATE = "Metadata.usp_v1_RowStatus_Update";

        #endregion

        #region Lookup

        public const string USP_VEHICLE_TYPE_INFO_GET = "Lookup.usp_v1_VehicleTypeInfo_Get";
        public const string USP_BOOKING_STATUS_INFO_GET = "Lookup.usp_v1_BookingStatusInfo_Get";
        public const string USP_COLOR_INFO_GET = "Lookup.usp_v1_ColorInfo_Get";
        public const string USP_GENDER_INFO_GET = "Lookup.usp_v1_GenderInfo_Get";



        #endregion

    }
}
