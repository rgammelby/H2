using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;

namespace Banker
{
    internal class Maestro : Card
    {
        private readonly int[] PREFIX = { 5018, 5020, 5038, 5893, 6304, 6759, 6761, 6762, 6763 };
        public string CardNumber { get { return _cardNumber; } }
        public DateTime ExpiryDate { get { return _expiry; } }
        public string Type { get { return _type; } }
        public string Name { get { return _name; } }

        public Maestro(string name) : base(name)
        {
            _name = name;
            _type = "Maestro";
            _cardNumber = GenerateCardNumber();
            _expiry = GenerateExpiryDate();
        }

        public override DateTime GenerateExpiryDate()
        {
            // expiry date always 5 years and 8 months from creation date
            return DateTime.Now.AddYears(5).AddMonths(8);
        }

        public override string GenerateCardNumber()
        {
            Random r = new Random();

            string cardNumber = PREFIX[r.Next(0, PREFIX.Length)].ToString();

            for (int i = 0; i < 3; i++)
            {
                string num = " " + new Random().Next(00000, 99999).ToString("D5");

                cardNumber += num;
                Thread.Sleep(10);
            }

            return cardNumber;
        }

        public override string ToString()
        {
            return base.ToString();
        }
    }
}
