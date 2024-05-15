using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using Flaskeautomaten.Consumers;
using System.Threading.Tasks;

namespace Flaskeautomaten.Buffers
{
    class TransitBuffer : Buffer
    {
        // Contains bottles sent by the producer
        public List<Bottle> TransitBottles = new List<Bottle>();

        object _lock = new object();

        public void SendBottleToSplitter(Bottle bottle, Splitter s)
        {
            s.SplitterBottles.Add(bottle);
        }

        public override void ReceiveBottles()
        {
            var bottlesReceived = 0;
            Splitter s = new Splitter();

            while (true)
            {
                Thread.Sleep(200);
                Monitor.Enter(_lock);
                if (TransitBottles.Count > 0)
                {
                    bottlesReceived++;
                    Console.WriteLine($"Bottle number {bottlesReceived} received in transit buffer! ");

                    SendBottleToSplitter(TransitBottles.Last(), s);
                    TransitBottles.Remove(TransitBottles.Last());
                    Console.WriteLine($"Bottle number {bottlesReceived} sent to splitter. ");
                }
                Monitor.Exit(_lock);
            }
        }

        public override void SendBottleToConsumer(Consumer c)
        {
            throw new NotImplementedException();
        }

        public TransitBuffer()
        {
            //Console.WriteLine("Creating new splitter... ");
            //Splitter s = new Splitter();
            Thread splitterThread = new Thread(() => ReceiveBottles());
            //ReceiveBottles(s);
            splitterThread.Start();
        }
    }
}
