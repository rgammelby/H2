using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Banker
{
    internal class Hævekort : Card
    {
        private const int PREFIX = 2400;

        public string CardNumber { get { return _cardNumber; } }
        public string ExpiryDate { get { return "No expiry date for this card type. "; } }

        public Hævekort()
        {
            _cardNumber = GenerateCardNumber();
        }
        public override DateTime GenerateExpiryDate()
        {
            // hævekort has no expiry date
            throw new NotImplementedException();
        }
        public override string GenerateCardNumber()
        {

            string cardNumber = PREFIX.ToString();

            for (int i = 0; i < 3; i++)
            {
                string num = " " + new Random().Next(0000, 9999).ToString("D4");

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
