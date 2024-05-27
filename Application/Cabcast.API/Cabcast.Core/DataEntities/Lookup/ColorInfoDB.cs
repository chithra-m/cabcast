using Cabcast.Core.Common.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cabcast.Core.DataEntities.Lookup
{
    public class ColorInfoDB : RowInfo
    {
        public string Color { get; set; } = null!;
        public string ColorValue { get; set; } = null!;
    }
}
