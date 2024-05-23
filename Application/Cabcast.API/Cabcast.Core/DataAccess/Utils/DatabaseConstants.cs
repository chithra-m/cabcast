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

        #endregion

    }
}
