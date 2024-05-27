using Cabcast.Core.Common.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cabcast.Core.DataEntities.Lookup
{
    public class GenderInfoDB : RowInfo
    {
        public string Gender { get; set; } = null!;
        public string GenderValue { get; set; } = null!;
    }
}
