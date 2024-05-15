using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using Flaskeautomaten.Buffers;
using System.Threading.Tasks;

namespace Flaskeautomaten
{
    /// <summary>
    /// The Producer class oversees production and initiates transit for all bottles.
    /// </summary>
    // produces bottles
    class Producer
    {
        // List of created bottles
        public List<Bottle> bottles = new List<Bottle>();

        // For synchronized bottle creation
        object _lock = new object();

        // creates and returns a beer bottle
        private Bottle CreateBeerBottle()
        {
            Bottle bottle = new Bottle(1);
            return bottle;
        }

        // creates and returns a soda bottle
        private Bottle CreateSodaBottle()
        {
            Bottle bottle = new Bottle(0);
            return bottle;
        }

        public void SendBottle(object o)
        {
            TransitBuffer tb = (TransitBuffer)o;

            // debug
            //Console.WriteLine("Producer attempting to send to TransitBuffer... ");
            //var bottlesSent = 0;

            while (bottles.Count > 0)
            {
                Monitor.Enter(_lock);

                // bottle removed from native Producer bottle list to avoid sending duplicate bottles
                Bottle bottle = bottles.Last();
                bottles.Remove(bottles.Last());

                // debug
                //bottlesSent++;
                //Console.WriteLine($"Bottle sent to Buffer. Bottles sent: {bottlesSent} ");

                // Bottle added to TransitBuffer list
                tb.TransitBottles.Add(bottle);
                Monitor.Exit(_lock);
            }
        }

        // prepares beer bottles for transit by adding them to the Producer bottle list
        // in principle takes object as parameter, but this was only instituted for me to be able to call it in a workqueue -
        // this was not strictly necessary, i learned, but i felt i needed to understand them better
        private void PrepareBeer(object obj)
        {
            var wait = 0;
            while (true)
            {
                Monitor.Enter(_lock);
                bottles.Add(CreateBeerBottle());
                Thread.Sleep(100);
                Console.WriteLine("Beer bottle created. ");
                Monitor.Exit(_lock);

                // short wait to ensure the remaining Producer thread can keep up with beer AND soda production threads
                wait++;
                if (wait > 50)
                    Thread.Sleep(100);
            }
        }

        // -//-
        private void PrepareSoda(object obj)
        {
            var wait = 0;
            while (true)
            {
                Monitor.Enter(_lock);
                bottles.Add(CreateSodaBottle());
                Thread.Sleep(100);
                Console.WriteLine("Soda bottle created. ");
                Monitor.Exit(_lock);

                wait++;
                if (wait > 50)
                    Thread.Sleep(100);
            }
        }

        // starts the production cycle; could've lived in a constructor
        public void StartProducer()
        {
            ThreadPool.QueueUserWorkItem(new WaitCallback(PrepareBeer));
            ThreadPool.QueueUserWorkItem(new WaitCallback(PrepareSoda));

            Thread.Sleep(500);

            Console.WriteLine("Initiating transit buffer... ");
            TransitBuffer transit = new TransitBuffer();

            ThreadPool.QueueUserWorkItem(new WaitCallback(SendBottle), transit);
        }
    }
}
