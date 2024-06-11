using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Banker
{
    internal class Account
    {
        private double _accountNumber;
        private int _regNumber;
        private string _accountHolderFirstName;
        private string _accountHolderLastName;

        private List<Card> _cards;

        private const int _regNumberPrefix = 3520;

        public double AccountNumber { get { return _accountNumber; } }
        public int RegNumber { get { return _regNumber; } }
        public string AccountHolderFirstName { get { return _accountHolderFirstName; } }
        public string AccountHolderLastName { get { return _accountHolderLastName; } }

        public Account(string fName, string lName)
        {
            _regNumber = _regNumberPrefix;
            _accountNumber = GenerateAccountNumber();
            _cards = new List<Card>();
            _accountHolderFirstName = fName;
            _accountHolderLastName = lName;
        }

        private double GenerateAccountNumber()
        {
            var acc = "";

            for (int i = 0; i < 3; i++)
            {
                acc += new Random().Next(0000, 9999).ToString("D4");
            }

            return double.Parse(acc);
        }

        private void AddCard(Card c)
        {
            _cards.Add(c);
        }

        private List<Card> ReturnCards()
        {
            return _cards;
        }
    }
}
