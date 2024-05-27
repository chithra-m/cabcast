using Cabcast.Core.Common.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cabcast.Core.DataEntities.Location
{
    public class AreaInfoDB : BaseInfo
    {
        public Guid Id { get; set; }
        public string Name { get; set; } = null!;
    }
}
