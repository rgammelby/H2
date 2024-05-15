using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Flaskeautomaten.Consumers
{
    class BeerConsumer : Consumer
    {
        public List<Bottle> BeerConsumerBottles = new List<Bottle>();

        public void DetectListChange()
        {
            var listLength = BeerConsumerBottles.Count;

            while (true)
            {
                if (listLength < BeerConsumerBottles.Count)
                {
                    PrintBottleInfo(BeerConsumerBottles.Last(), BeerConsumerBottles.Count);
                    listLength = BeerConsumerBottles.Count;
                }
            }
        }

        public BeerConsumer()
        {
            Thread t = new Thread(new ThreadStart(DetectListChange));
            Console.ForegroundColor = ConsoleColor.DarkYellow;
            Console.WriteLine("Listening for incoming beer bottles... ");
            Console.ForegroundColor = ConsoleColor.White;
            t.Start();
        }
    }
}
