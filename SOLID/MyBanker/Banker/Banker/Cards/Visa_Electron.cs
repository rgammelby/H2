using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using System.Xml.Linq;

namespace Banker
{
    internal class Visa_Electron : Card
    {
        private readonly int[] PREFIX = { 4026, 417500, 4508, 4844, 4913, 4917 };
        public string CardNumber { get { return _cardNumber; } }
        public DateTime ExpiryDate { get { return _expiry; } }
        public string Type { get { return _type; } }
        public string Name { get { return _name; } }

        public Visa_Electron(string name) : base(name)
        {
            _name = name;
            _type = "VISA Electron";
            _cardNumber = GenerateCardNumber();
            _expiry = GenerateExpiryDate();
        }

        // generates expiry date 5 years from creation date
        public override DateTime GenerateExpiryDate()
        {
            return DateTime.Now.AddYears(5);
        }

        // generates a 16 digit card number including the 4 digit prefix
        public override string GenerateCardNumber()
        {
            Random r = new Random();

            string cardNumber = PREFIX[r.Next(0, PREFIX.Length)].ToString();

            if (cardNumber.Length == 4 )
            {
                for (int i = 0; i < 3; i++)
                {
                    string num = " " + new Random().Next(0000, 9999).ToString("D4");

                    cardNumber += num;
                    Thread.Sleep(10);
                }
            }

            else if (cardNumber.Length == 6 )
            {
                for (int i = 0; i < 2; i++)
                {
                    string num = " " + new Random().Next(00000, 99999).ToString("D4");

                    cardNumber += num;
                }
            }

            return cardNumber;
        }

        public override string ToString()
        {
            return base.ToString();
        }
    }
}
