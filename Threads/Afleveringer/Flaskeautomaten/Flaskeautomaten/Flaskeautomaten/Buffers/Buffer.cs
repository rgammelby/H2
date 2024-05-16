using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Flaskeautomaten.Consumers;
using System.Threading.Tasks;

namespace Flaskeautomaten.Buffers
{
    /// <summary>
    /// Tiny parent class containing only a single abstract method used by child buffer classes
    /// </summary>
    abstract class Buffer
    {
        public abstract void SendBottleToConsumer(Consumer c);
    }
}
