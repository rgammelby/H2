using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Banker
{
    internal abstract class Card
    {
        protected string _name;
        protected string _cardNumber;
        protected DateTime _expiry;
        protected string _type;

        public string Type { get { return _type; } }
        public string CardNumber { get { return _cardNumber; } }
        public DateTime Expiry { get { return _expiry; } }
        public string Name { get { return _name; } }

        protected Card(string name)
        {
            _name = name;
            _cardNumber = GenerateCardNumber();
            _expiry = GenerateExpiryDate();
        }


        public abstract string GenerateCardNumber();
        public abstract DateTime GenerateExpiryDate();

        public string ReturnCardInformation()
        {
            return $"Type: {Type}\nCard number: {CardNumber}\nExpiry: {Expiry} ({Expiry.Year - DateTime.Now.Year} years and {Expiry.Month - DateTime.Now.Month} months from now.)\nCard owner: {Name}";
        }
    }
}
