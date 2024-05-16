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
    /// This buffer class forwards bottles from the splitter specifically addressed to the SODA CONSUMER.
    /// </summary>
    class SodaConsumerBuffer : Buffer
    {
        // Contains soda bottles as sorted by the Splitter
        public List<Bottle> SodaBottles = new List<Bottle>();

        object _lock = new object();

        // fowards bottles to relevant consumer (adding to soda consumer's list)
        public override void SendBottleToConsumer(Consumer c)
        {
            SodaConsumer soda = c as SodaConsumer;

            while (true)
            {
                while (SodaBottles.Count > 0)
                {
                    Monitor.Enter(_lock);
                    soda.SodaConsumerBottles.Add(SodaBottles.Last());
                    SodaBottles.Remove(SodaBottles.Last());
                    Monitor.Exit(_lock);

                    //// debug
                    //Console.ForegroundColor = ConsoleColor.Green;
                    //Console.WriteLine("Soda bottle sent to soda consumer! ");
                    //Console.ForegroundColor = ConsoleColor.White;
                }
            }
        }

        // soda forwarding method starts automatically in buffer constructor
        public SodaConsumerBuffer()
        {
            SodaConsumer c = new SodaConsumer();
            Thread t = new Thread(() => SendBottleToConsumer(c));
            t.Start();
        }
    }
}
