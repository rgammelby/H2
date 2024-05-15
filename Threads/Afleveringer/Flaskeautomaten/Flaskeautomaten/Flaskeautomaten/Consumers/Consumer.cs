using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Flaskeautomaten.Consumers
{
    class Consumer
    {

        // print info about pickups
        public void PrintBottleInfo(Bottle bottle, int amount)
        {
            // import bottle information
            var bottleInfo = bottle.ReturnBottleInformation();

            // declare variables for each bottle property
            var designation = bottleInfo.Item1;
            var serial = bottleInfo.Item2;

            // print bottle properties
            Console.ForegroundColor = ConsoleColor.Cyan;
            Console.WriteLine($"\nBottle designation: {bottle.GetDesignation(designation)}\n" +
                $"Serial number: {serial}\n" +
                $"Bottle number: {amount} ");
            Console.ForegroundColor = ConsoleColor.White;
        }
    }
}
