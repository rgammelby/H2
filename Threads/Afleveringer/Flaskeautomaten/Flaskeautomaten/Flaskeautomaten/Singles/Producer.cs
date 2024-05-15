using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using Flaskeautomaten.Buffers;
using System.Threading.Tasks;

namespace Flaskeautomaten
{
    // produces bottles
    class Producer
    {
        // List of created bottles
        public List<Bottle> bottles = new List<Bottle>();

        // For synchronized bottle creation
        object _lock = new object();

        private Bottle CreateBeerBottle()
        {
            Bottle bottle = new Bottle(1);
            return bottle;
        }

        private Bottle CreateSodaBottle()
        {
            Bottle bottle = new Bottle(0);
            return bottle;
        }

        public void SendBottle(object o)
        {
            TransitBuffer tb = (TransitBuffer)o;

            Console.WriteLine("Producer attempting to send to TransitBuffer... ");
            // debug
            var bottlesSent = 0;

            while (bottles.Count > 0)
            {
                Monitor.Enter(_lock);
                Bottle bottle = bottles.Last();
                bottles.Remove(bottles.Last());

                // debug
                bottlesSent++;

                tb.TransitBottles.Add(bottle);
                Console.WriteLine($"Bottle sent to Buffer. Bottles sent: {bottlesSent} ");
                Monitor.Exit(_lock);
            }
        }

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

                wait++;
                if (wait > 50)
                    Thread.Sleep(100);
            }
        }

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
