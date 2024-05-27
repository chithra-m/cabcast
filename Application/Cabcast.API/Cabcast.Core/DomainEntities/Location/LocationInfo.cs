using Cabcast.Core.Common.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cabcast.Core.DomainEntities.Location
{
    public class LocationInfo : BaseInfo
    {
        public Guid Id { get; set; }
        public string Name { get; set; } = null!;
        public string AddressLine { get; set; } = null!;
        public AreaInfo AreaInfo { get; set; } = null!;
        public SubAreaInfo SubAreaInfo { get; set; } = null!;
        public string Pincode { get; set; } = null!;
        public byte DistanceFromOfficeInKM { get; set; }
        public TimeSpan DurationByOffice { get; set; }
    }
}
