using Flaskeautomaten.Buffers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Flaskeautomaten
{
    /// <summary>
    /// The Splitter class sorts bottles by designation and sends them out to the correct buffer.
    /// </summary>
    class Splitter
    {
        public List<Bottle> SplitterBottles = new List<Bottle>();

        object _lock = new object();

        // Retrieves and returns a bottle from the Splitter bottle list
        public Bottle RetrieveBottleFromList()
        {
            // debug
            //Console.WriteLine("Getting bottle from Splitter List... ");

            while (true)
            {
                Monitor.Enter(_lock);
                Bottle b = SplitterBottles.Last();
                SplitterBottles.Remove(SplitterBottles.Last());
                Monitor.Exit(_lock);

                return b;
            }
        }

        public void SplitterSort(BeerConsumerBuffer b, SodaConsumerBuffer s)
        {
            while (true)
            {
                // when Splitter bottle list is empty, wait
                while (SplitterBottles.Count < 1)
                {
                    Thread.Sleep(500);

                    //// debug
                    //Console.ForegroundColor = ConsoleColor.Red;
                    //Console.WriteLine("Waiting to receive bottles from transit buffer... ");
                    //Console.ForegroundColor = ConsoleColor.White;
                }

                // if not empty, begin sorting process
                while (SplitterBottles.Count > 1)
                {
                    Monitor.Enter(_lock);
                    Bottle bottle = RetrieveBottleFromList();
                    Console.ForegroundColor = ConsoleColor.Red;
                    var bottleInfo = bottle.ReturnBottleInformation();

                    // add bottle to relevant list based on designation retrieved in ReturnBottleInformation method
                    if (bottleInfo.Item1 == 0)
                    {
                        b.BeerBottles.Add(bottle);

                        // debug
                        //Console.WriteLine("Bottle sent from Splitter to Beer Buffer. ");
                    }
                    else
                    {
                        s.SodaBottles.Add(bottle);

                        // debug
                        //Console.WriteLine("Bottle sent from Splitter to Soda Buffer. ");
                    }
                    Console.ForegroundColor = ConsoleColor.White;
                    Monitor.Exit(_lock);
                }
            }
        }

        public void SplitterManager()
        {
            Console.ForegroundColor = ConsoleColor.Red;

            BeerConsumerBuffer bcb = new BeerConsumerBuffer();
            SodaConsumerBuffer scb = new SodaConsumerBuffer();

            Console.WriteLine("Starting SplitterSort thread. ");
            Thread t = new Thread(() => SplitterSort(bcb, scb));

            t.Start();
            Console.WriteLine("SplitterSort thread started. ");
            Console.ForegroundColor = ConsoleColor.White;
        }

        public Splitter()
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Splitter created. Running SplitterManager... ");
            SplitterManager();
            Console.WriteLine("SplitterManager has run/is running. ");
            Console.ForegroundColor = ConsoleColor.White;
        }
    }
}
