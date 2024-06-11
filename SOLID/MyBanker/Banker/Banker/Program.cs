using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Banker
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // small demonstration
            Account pj = new Account("Peter", "Jensen", 41, 53915);
            pj.NewCard("Mastercard");
            pj.NewCard("VISA");

            foreach (Card c in pj.ReturnCards())
            {
                Console.WriteLine(c.ReturnCardInformation());
            }

            Account la = new Account("Lisa", "Andersen", 17, 127);

            la.NewCard("Visa Electron");

            foreach (Card c in la.ReturnCards())
            {
                Console.WriteLine(c.ReturnCardInformation());
            }

            Console.ReadLine();
        }
    }
}
