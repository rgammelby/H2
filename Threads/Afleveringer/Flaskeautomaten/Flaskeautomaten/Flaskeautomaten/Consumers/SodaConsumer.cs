using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Flaskeautomaten.Consumers
{
    /// <summary>
    /// The SodaConsumer class is a child of the Consumer superclass. It contains a list and a listener; calls out SODA BOTTLES received, and prints
    /// info (type and serial number) of the received bottle.
    /// </summary>

    class SodaConsumer : Consumer
    {
        public List<Bottle> SodaConsumerBottles = new List<Bottle>();

        public void DetectListChange()
        {
            var listLength = SodaConsumerBottles.Count;

            while (true)
            {
                if (listLength < SodaConsumerBottles.Count)
                {
                    PrintBottleInfo(SodaConsumerBottles.Last(), SodaConsumerBottles.Count);
                    listLength = SodaConsumerBottles.Count;
                }
            }
        }

        public SodaConsumer()
        {
            Thread t = new Thread(new ThreadStart(DetectListChange));
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine("Listening for incoming soda bottles... ");
            Console.ForegroundColor = ConsoleColor.White;
            t.Start();
        }
    }
}
