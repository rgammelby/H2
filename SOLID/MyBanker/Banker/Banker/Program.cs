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
        private static readonly int[] PREFIXES = { 5018, 5020, 5038, 5893, 6304, 6759, 6761, 6762, 6763 };

        static void Main(string[] args)
        {
            Hævekort hk = new Hævekort();
            var hkc = hk.GenerateCardNumber();
            Console.WriteLine("Hævekort: " + hkc + $" Length: {Regex.Replace(hkc, @"\s+", "").Length}");

            Console.WriteLine(hk.CardNumber + " " + hk.ExpiryDate);


            Maestro m = new Maestro();
            var mcn = m.GenerateCardNumber();
            Console.WriteLine("Maestro: " + mcn + $" Length: {Regex.Replace(mcn, @"\s+", "").Length}");

            Console.WriteLine(m.CardNumber + " " + m.ExpiryDate);

            Mastercard mc = new Mastercard();
            var mcc = mc.GenerateCardNumber();
            Console.WriteLine("Mastercard: " + mcc + $" Length: {Regex.Replace(mcc, @"\s+", "").Length}");

            Console.WriteLine(mc.CardNumber + " " + mc.ExpiryDate);

            VISA v = new VISA();
            var vn = v.GenerateCardNumber();
            Console.WriteLine("VISA: " + vn + $" Length: {Regex.Replace(vn, @"\s+", "").Length}");

            Console.WriteLine(v.CardNumber + " " + v.ExpiryDate);

            Visa_Electron ve = new Visa_Electron();
            var ven = ve.GenerateCardNumber();
            Console.WriteLine("Visa Electron: " + ven + $" Length: {Regex.Replace(ven, @"\s+", "").Length}");

            Console.WriteLine(ve.CardNumber + " " + v.ExpiryDate);

            Console.ReadLine();
        }
    }
}
