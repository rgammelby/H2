using Flaskeautomaten.Buffers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Flaskeautomaten
{
    class Splitter
    {
        public List<Bottle> SplitterBottles = new List<Bottle>();

        object _lock = new object();

        // RETRIEVE BOTTLE FROM SPLITTER LIST
        public Bottle SendBottleToBuffer()
        {
            Console.WriteLine("Getting bottle from Splitter List... ");
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
            Console.WriteLine($"SplitterSort is running. SplitterBottles count: {SplitterBottles.Count}");

            // WRITE LISTENER FOR SPLITTER

            while (true)
            {
                while (SplitterBottles.Count < 1)
                {
                    Thread.Sleep(500);
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("Waiting to receive bottles from transit buffer... ");
                    Console.ForegroundColor = ConsoleColor.White;
                }

                while (SplitterBottles.Count > 1)
                {
                    Monitor.Enter(_lock);
                    Bottle bottle = SendBottleToBuffer();
                    Console.ForegroundColor = ConsoleColor.Red;
                    var bottleInfo = bottle.ReturnBottleInformation();

                    if (bottleInfo.Item1 == 0)
                    {
                        b.BeerBottles.Add(bottle);
                        Console.WriteLine("Bottle sent from Splitter to Beer Buffer. ");
                    }
                    else
                    {
                        s.SodaBottles.Add(bottle);
                        Console.WriteLine("Bottle sent from Splitter to Soda Buffer. ");
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
