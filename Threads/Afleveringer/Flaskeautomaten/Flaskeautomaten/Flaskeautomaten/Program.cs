using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Flaskeautomaten
{
    internal class Program
    {
        /* Producer sender øl- eller sodavandsflasker ud på et bånd
         * Consumer/splitter henter flaskerne fra åbndet og sender dem ud på to bånd
         * Consumer henter flasker fra Øl bånd
         * Consumer henter flasker fra Consumer bånd
         */

        static void Main(string[] args)
        {
            // Create Producer
            // Start bottle creation loop
            Producer p = new Producer();
            p.StartProducer();

            // Send bottles to transit (Buffer) with Producer
            // Transit (Buffer) to Sorting Facility (Splitter)
            // Transit buffer init
            Buffer transit = new Buffer();

            // Transit (Buffer) from Splitter Facility
            // Transit to Bar (Beer Buffer)
            // Transit to Soda... bar? (Soda Buffer)

            // Consumer buys and brags about BEER
            // Consumer buys and brags about SODA

        }
    }

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

        public void SendBottle()
        {
            // debug
            var bottlesSent = 0;

            while(bottles.Count > 0)
            {
                Monitor.Enter(_lock);
                Bottle bottle = bottles.Last();
                bottles.Remove(bottles.Last());

                // debug
                bottlesSent++;
                Buffer transit = new Buffer();

                transit.TransitBottles.Add(bottle);
                Console.WriteLine($"Bottle sent to Buffer. Bottles sent: {bottlesSent} ");
                Monitor.Exit(_lock);
            }
        }

        private void PrepareBeer()
        {
            while(true)
            {
                Monitor.Enter(_lock);
                bottles.Add(CreateBeerBottle());
                Thread.Sleep(100);
                Console.WriteLine("Beer bottle created. ");
                Monitor.Exit(_lock);
            }
        }

        private void PrepareSoda()
        {
            while(true)
            {
                Monitor.Enter(_lock);
                bottles.Add(CreateSodaBottle());
                Thread.Sleep(100);
                Console.WriteLine("Soda bottle created. ");
                Monitor.Exit(_lock);
            }
        }

        // Create and prepare bottles
        //public void Factory()
        //{
        //    while(true)
        //    {
        //        PrepareBeer();
        //        PrepareSoda();
        //    }
        //}

        public void StartProducer()
        {
            Thread beer = new Thread(new ThreadStart(PrepareBeer));
            Thread soda = new Thread(new ThreadStart(PrepareSoda));

            beer.Start();
            soda.Start();

            Thread.Sleep(2000);

            Thread sendBottles = new Thread(new ThreadStart(SendBottle));

            sendBottles.Start();
        }
    }

    // carries a designation; Øl/Sodavand
    class Bottle
    {
        private List<int> SerialNumbers = new List<int>();

        enum BottleDesignation { Soda, Beer };

        // Bottle designation; beer or soda
        private byte _designation;

        // Serial number
        private int _serial;

        public (byte, int) ReturnBottleInformation()
        {
            return (this._designation, this._serial);
        }

        public Bottle(byte designation)
        {
            _designation = designation;
            _serial = GenerateSerialNumber();
        }

        // Generates a unique serial number for a new bottle
        private int GenerateSerialNumber()
        {
            // Creates a random 5-number serial number
            Random r = new Random();
            var serialNo = r.Next(9999, 99999);

            if (SerialNumbers.Contains(serialNo))
                serialNo = GenerateSerialNumber();
            else
                // Stores created serial numbers in a list
                SerialNumbers.Add(serialNo);

            Console.WriteLine("Unique serial number generated. ");
            return serialNo;
        }
    }

    // carries bottle from producer to splitter & splitter to consumer
    class Buffer
    {
        // Contains bottles sent by the producer
        public List<Bottle> TransitBottles = new List<Bottle>();

        // Contains beer bottles as sorted by the Splitter
        public List<Bottle> BeerBottles = new List<Bottle>();

        // Contains soda bottles as sorted by the Splitter
        public List<Bottle> SodaBottles = new List<Bottle>();

        // Producer defined in main PROGRAM 
        //public Bottle RetrieveBottle(Producer p)
        //{
        //    Bottle bottle = p.bottles.Last();
        //    p.bottles.Remove(p.bottles.Last());

        //    Console.WriteLine("Bottle received (Buffer). ");
        //    return bottle;
        //}

        public void SendBottleToSplitter(Bottle bottle, Splitter s)
        {
            s.SplitterBottles.Add(bottle);
        }

        public void SendBottleToBeerConsumer(Consumer c)
        {
            while(BeerBottles.Count > 0)
            {
                c.BeerConsumerBottles.Add(BeerBottles.Last());
                BeerBottles.Remove(BeerBottles.Last());
            }
        }

        public void SendBottleToSodaConsumer(Consumer c)
        {
            while(SodaBottles.Count > 0)
            {
                c.SodaConsumerBottles.Add(SodaBottles.Last());
                SodaBottles.Remove(SodaBottles.Last());
            }
        }

        public void ReceiveBottles()
        {
            Splitter s = new Splitter();
            var bottleCount = TransitBottles.Count;

            while (true)
            {
                if (TransitBottles.Count > bottleCount)
                {
                    Console.WriteLine($"Bottle received in transit buffer! ");
                    bottleCount = TransitBottles.Count;

                    SendBottleToSplitter(TransitBottles.Last(), s);
                    Console.WriteLine("Bottle sent to splitter. ");
                }
            }
        }

        public void SendBottles()
        {
            Consumer a = new Consumer();
            Consumer b = new Consumer();

            Thread beer = new Thread(() => SendBottleToBeerConsumer(a));
            Thread soda = new Thread(() => SendBottleToSodaConsumer(b));

            beer.Start();
            soda.Start();
        }

        public Buffer()
        {
            Thread t = new Thread(new ThreadStart(ReceiveBottles));

            t.Start();
        }
    }

    // sends bottles to 1 of 2 conveyors according to designation (Øl/Sodavand)
    class Splitter
    {
        public List<Bottle> SplitterBottles = new List<Bottle>();

        object _lock = new object();

        //public void ReceiveBottles(Producer p)
        //{
        //    Buffer transit = new Buffer();
        //    SplitterBottles.Add(transit.SendBottleToSplitter(p));
        //}

        public Bottle SendBottleToBuffer()
        {
            while(true)
            {
                Monitor.Enter(_lock);
                Bottle b = SplitterBottles.Last();
                SplitterBottles.Remove(SplitterBottles.Last());
                Monitor.Exit(_lock);

                return b;
            }
        }

        //public Bottle SendBottleToSodaBuffer()
        //{
        //    Bottle b = SplitterBottles.Last();
        //    SplitterBottles.Remove(SplitterBottles.Last());

        //    return b;
        //}

        public void SplitterSort()
        {
            Buffer beer = new Buffer();
            Buffer soda = new Buffer();

            // WRITE LISTENER FOR SPLITTER

            Bottle bottle = SendBottleToBuffer();

            var bottleInfo = bottle.ReturnBottleInformation();

            if (bottleInfo.Item1 == 0)
                beer.BeerBottles.Add(bottle);
            else 
                soda.SodaBottles.Add(bottle);
        }

        public void SplitterManager()
        {
            Thread t = new Thread(new ThreadStart(SplitterSort));

            t.Start();
        }
    }

    // picks up and contains bottles of their specific kind (Øl/Sodavand)
    class Consumer
    {
        public List<Bottle> BeerConsumerBottles = new List<Bottle>();
        public List<Bottle> SodaConsumerBottles = new List<Bottle>();

        // print info about pickups
        public void PrintBottleInfo(Bottle bottle)
        {
            // import bottle information
            var bottleInfo = bottle.ReturnBottleInformation();

            // declare variables for each bottle property
            var designation = bottleInfo.Item1;
            var serial = bottleInfo.Item2;

            // print bottle properties
            Console.WriteLine($"\nBottle designation: {designation}\n" +
                $"Serial number: {serial} ");
        }

        // Listen for changes to bottle lists
        public void ListChangeListener()
        {
            Thread beerListener = new Thread(new ThreadStart(DetectBeerListChange));
            Thread sodaListener = new Thread(new ThreadStart(DetectSodaListChange));


            beerListener.Start();
            sodaListener.Start();
        }

        public void DetectBeerListChange()
        {
            var listLength = BeerConsumerBottles.Count;

            while (true)
            {
                if (listLength < BeerConsumerBottles.Count)
                {
                    PrintBottleInfo(BeerConsumerBottles.Last());
                    listLength = BeerConsumerBottles.Count;
                }
            }
        }

        public void DetectSodaListChange()
        {
            var listLength = SodaConsumerBottles.Count;

            while (true)
            {
                if (listLength < SodaConsumerBottles.Count)
                {
                    PrintBottleInfo(SodaConsumerBottles.Last());
                    listLength = SodaConsumerBottles.Count;
                }
            }
        }

        public Consumer()
        {
            ListChangeListener();
        }
    }
}
