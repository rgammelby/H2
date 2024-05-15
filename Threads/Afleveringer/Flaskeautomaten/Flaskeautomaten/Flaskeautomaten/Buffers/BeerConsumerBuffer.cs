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

        //public override void ReceiveBottles()
        //{
        //    var bottleCount = BeerBottles.Count;

        //    // Continues to send beer bottles to beer consumers as long as beer is available
        //    while (BeerBottles.Count > 0)
        //    {
        //        Monitor.Enter(_lock);
        //        if (BeerBottles.Count > bottleCount)
        //        {
        //            //debug
        //            //Console.WriteLine($"Bottle received in transit buffer! ");
        //            bottleCount = BeerBottles.Count;

        //            // debug
        //            Console.WriteLine("Forwarding bottles to consumer has not been implemented yet. ");
        //        }
        //        Monitor.Exit(_lock);
        //    }
        //}

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

        public BeerConsumerBuffer()
        {
            BeerConsumer c = new BeerConsumer();
            Thread t = new Thread(() => SendBottleToConsumer(c));
            t.Start();
        }
    }
}
