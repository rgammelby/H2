using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace ThreadPoolProperties
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Thread t = new Thread(new ThreadStart(FuckYou));
            t.Start();

            Console.WriteLine($"Thread.IsAlive: {t.IsAlive} ");
            Console.WriteLine($"Thread.IsBackground: {t.IsBackground}");
            Console.WriteLine($"Thread priority: {t.Priority.ToString()}");

            Console.Read();
        }

        static void FuckYou()
        {
            Console.WriteLine("Fuck you. ");
        }
    }
}
