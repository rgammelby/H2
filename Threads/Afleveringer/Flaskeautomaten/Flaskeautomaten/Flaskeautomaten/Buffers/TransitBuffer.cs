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
    /// The TransitBuffer class receives bottles - beer and soda - directly from the producer, and sends them on the Splitter class for 'processing'.
    /// </summary>
    class TransitBuffer : Buffer
    {
        // Contains bottles sent by the producer
        public List<Bottle> TransitBottles = new List<Bottle>();

        object _lock = new object();

        // bottles added to splitter list
        public void SendBottleToSplitter(Bottle bottle, Splitter s)
        {
            s.SplitterBottles.Add(bottle);
        }

        // doesn't actually receive bottles, but the method was named for its debug callouts
        public void ReceiveBottles()
        {
            // debug
            //var bottlesReceived = 0;
            Splitter s = new Splitter();

            while (true)
            {
                // small break to ensure all of the threads run smoothly alongside one another
                Thread.Sleep(200);
                Monitor.Enter(_lock);

                // as soon as & as long as there are bottles to forward, they are forwarded to the splitter class
                if (TransitBottles.Count > 0)
                {
                    SendBottleToSplitter(TransitBottles.Last(), s);

                    // removes last (sent) entry to ensure no bottle is sent twice
                    TransitBottles.Remove(TransitBottles.Last());

                    ////debug
                    //bottlesReceived++;
                    //Console.WriteLine($"Bottle number {bottlesReceived} received in transit buffer! ");
                    //Console.WriteLine($"Bottle number {bottlesReceived} sent to splitter. ");
                }
                Monitor.Exit(_lock);
            }
        }

        // avoid abstract method error
        public override void SendBottleToConsumer(Consumer c)
        {
            throw new NotImplementedException();
        }

        // process starts automatically in constructor
        public TransitBuffer()
        {
            Thread splitterThread = new Thread(() => ReceiveBottles());
            splitterThread.Start();
        }
    }
}
