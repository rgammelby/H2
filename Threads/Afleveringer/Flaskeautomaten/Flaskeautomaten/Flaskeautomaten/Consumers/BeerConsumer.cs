using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Flaskeautomaten.Consumers
{
    /// <summary>
    /// The BeerConsumer class is a child of the Consumer superclass. It contains a list and a listener; calls out BEER BOTTLES received, and prints
    /// info (type and serial number) of the received bottle.
    /// </summary>
    class BeerConsumer : Consumer
    {
        // end point for beer bottles
        public List<Bottle> BeerConsumerBottles = new List<Bottle>();

        // continuously listens for new bottle arrivals
        public void DetectListChange()
        {
            var listLength = BeerConsumerBottles.Count;

            while (true)
            {
                if (listLength < BeerConsumerBottles.Count)
                {
                    // upon new arrival, prints bottle info and resets listLength
                    PrintBottleInfo(BeerConsumerBottles.Last(), BeerConsumerBottles.Count);
                    listLength = BeerConsumerBottles.Count;
                }
            }
        }

        // listener and bottle info callouts start automatically in constructor
        public BeerConsumer()
        {
            Thread t = new Thread(new ThreadStart(DetectListChange));
            t.Start();

            // debug
            //Console.ForegroundColor = ConsoleColor.DarkYellow;
            //Console.WriteLine("Listening for incoming beer bottles... ");
            //Console.ForegroundColor = ConsoleColor.White;
        }
    }
}
