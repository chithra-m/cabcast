using Cabcast.Core.Common.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cabcast.Core.DataEntities.Location
{
    public class LocationInfoDB : BaseInfo
    {
        public Guid Id { get; set; }
        public string Name { get; set; } = null!;
        public string AddressLine { get; set; } = null!;
        public Guid SubAreaInfoId { get; set; }
        public Guid SubAreaInfoName { get; set; }
        public Guid AreaInfoId { get; set; }
        public Guid AreaInfoName { get; set; }
        public string Pincode { get; set; } = null!;
        public byte DistanceFromOfficeInKM { get; set; }
        public TimeSpan DurationByOffice { get; set; }  
    }
}
