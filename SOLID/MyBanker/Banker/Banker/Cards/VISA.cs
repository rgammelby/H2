using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using System.Xml.Linq;

namespace Banker
{
    internal class VISA : Card
    {
        private const int PREFIX = 4;
        public string CardNumber { get { return _cardNumber; } }
        public DateTime ExpiryDate { get { return _expiry; } }
        public string Type { get { return _type; } }
        public string Name { get { return _name; } }

        public VISA(string name) : base(name)
        {
            _name = name;
            _type = "VISA";
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

            string cardNumber = PREFIX.ToString();

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
