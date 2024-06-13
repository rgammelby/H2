using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kaffemaskinen
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // a small demonstration, input your own numbers if you please
            CoffeeMachine moccamaster = new CoffeeMachine(2000);
            moccamaster.WaterContainer.Fill(1953);
            moccamaster.Filter.Fill(7);

            Console.WriteLine($"{(float)moccamaster.WaterContainer.Volume / moccamaster.Filter.CoffeeSpoons} mL of water per spoonful of coffee. ");

            Console.WriteLine($"{moccamaster.Brew()} cups of coffee brewed. ");

            Console.ReadLine();
        }
    }
}
