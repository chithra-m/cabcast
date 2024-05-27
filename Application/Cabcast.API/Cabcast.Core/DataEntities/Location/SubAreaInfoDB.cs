using Cabcast.Core.Common.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cabcast.Core.DataEntities.Location
{
    public class SubAreaInfoDB : BaseInfo
    {
        public Guid Id { get; set; }
        public string Name { get; set; } = null!;
        public Guid AreaInfoId { get; set; }
        public string AreaInfoName { get; set; } = null!;
    }
}
