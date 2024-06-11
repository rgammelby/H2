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
        protected double _accountNumber;

        public abstract string GenerateCardNumber();
        public abstract DateTime GenerateExpiryDate();
    }
}
