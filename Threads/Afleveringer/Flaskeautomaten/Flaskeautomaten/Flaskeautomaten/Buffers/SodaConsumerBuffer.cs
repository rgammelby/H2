using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using Flaskeautomaten.Consumers;
using System.Threading.Tasks;

namespace Flaskeautomaten.Buffers
{
    class SodaConsumerBuffer : Buffer
    {
        // Contains soda bottles as sorted by the Splitter
        public List<Bottle> SodaBottles = new List<Bottle>();

        object _lock = new object();

        //public override void ReceiveBottles()
        //{
        //    var bottleCount = SodaBottles.Count;

        //    while (SodaBottles.Count > 1)
        //    {
        //        if (SodaBottles.Count > bottleCount)
        //        {
        //            Console.WriteLine($"Bottle received in transit buffer! ");
        //            bottleCount = SodaBottles.Count;

        //            // SEND TO CONSUMER
        //            Console.WriteLine("Forwarding bottles to consumer has not been implemented yet. ");
        //            //SendBottleToSplitter(SodaBottles.Last(), s);
        //            //SodaBottles.Remove(SodaBottles.Last());
        //        }
        //    }
        //}

        public override void SendBottleToConsumer(Consumer c)
        {
            SodaConsumer soda = c as SodaConsumer;

            while (true)
            {
                while (SodaBottles.Count > 0)
                {
                    Monitor.Enter(_lock);
                    soda.SodaConsumerBottles.Add(SodaBottles.Last());
                    Console.ForegroundColor = ConsoleColor.Green;
                    Console.WriteLine("Soda bottle sent to soda consumer! ");
                    Console.ForegroundColor = ConsoleColor.White;
                    SodaBottles.Remove(SodaBottles.Last());
                    Monitor.Exit(_lock);
                }
            }
        }

        public SodaConsumerBuffer()
        {
            SodaConsumer c = new SodaConsumer();
            Thread t = new Thread(() => SendBottleToConsumer(c));
            t.Start();
        }
    }
}
