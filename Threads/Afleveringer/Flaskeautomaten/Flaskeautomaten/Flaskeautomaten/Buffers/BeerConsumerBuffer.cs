using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using Flaskeautomaten.Consumers;
using System.Threading.Tasks;

namespace Flaskeautomaten.Buffers
{
    /// <summary>
    /// This buffer class forwards bottles from the splitter specifically addressed to the BEER CONSUMER.
    /// </summary>
    class BeerConsumerBuffer : Buffer
    {
        // Contains beer bottles as sorted by the Splitter
        public List<Bottle> BeerBottles = new List<Bottle>();

        object _lock = new object();

        // Sends bottles (adds to list of) the relevant consumer
        public override void SendBottleToConsumer(Consumer c)
        {
            BeerConsumer beer = c as BeerConsumer;

            while (true)
            {
                while (BeerBottles.Count > 0)
                {
                    beer.BeerConsumerBottles.Add(BeerBottles.Last());
                    BeerBottles.Remove(BeerBottles.Last());
                }
            }
        }

        // constructor starts the beer forwarding process automatically
        public BeerConsumerBuffer()
        {
            BeerConsumer c = new BeerConsumer();
            Thread t = new Thread(() => SendBottleToConsumer(c));
            t.Start();
        }
    }
}
