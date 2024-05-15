using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Flaskeautomaten
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // Create Producer
            // Start bottle creation loop
            Producer p = new Producer();
            p.StartProducer();
        }
    }
}
