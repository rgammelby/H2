using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Flaskeautomaten.Consumers;
using System.Threading.Tasks;

namespace Flaskeautomaten.Buffers
{
    abstract class Buffer
    {


        // Producer defined in main PROGRAM 
        //public Bottle RetrieveBottle(Producer p)
        //{
        //    Bottle bottle = p.bottles.Last();
        //    p.bottles.Remove(p.bottles.Last());

        //    Console.WriteLine("Bottle received (Buffer). ");
        //    return bottle;
        //}

        public abstract void ReceiveBottles();

        public abstract void SendBottleToConsumer(Consumer c);
    }
}
