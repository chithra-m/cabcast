﻿using Cabcast.Core.Common.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cabcast.Core.DomainEntities.Location
{
    public class AreaInfo : BaseInfo
    {
        public Guid Id { get; set; }
        public string Name { get; set; } = null!;
    }
}
