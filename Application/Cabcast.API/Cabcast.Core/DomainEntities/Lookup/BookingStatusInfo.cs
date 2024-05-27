using Cabcast.Core.Common.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cabcast.Core.DomainEntities.Lookup
{
    public class BookingStatusInfo : RowInfo
    {
        public string BookingStatus { get; set; } = null!;
        public string BookingStatusValue { get; set; } = null!;
    }
}
