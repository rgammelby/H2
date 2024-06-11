using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;

namespace Banker
{
    internal class Mastercard : Card
    {
        private readonly int[] PREFIX = { 51, 52, 53, 54, 55 };
        public string CardNumber { get { return _cardNumber; } }
        public DateTime ExpiryDate { get { return _expiry; } }
        public string Type { get { return _type; } }
        public string Name { get { return _name; } }

        public Mastercard(string name) : base(name)
        {
            _name = name;
            _type = "Mastercard";
            _cardNumber = GenerateCardNumber();
            _expiry = GenerateExpiryDate();
        }

        public override DateTime GenerateExpiryDate()
        {
            // must never be greater than 5 years from creation date
            return DateTime.Now.AddYears(5);
        }

        public override string GenerateCardNumber()
        {
            Random r = new Random();

            string cardNumber = PREFIX[r.Next(0, PREFIX.Length)].ToString();

            for (int i = 0; i < 2; i++)
            {
                string num = " " + new Random().Next(0000000, 9999999).ToString("D7");

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
