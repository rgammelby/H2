using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Banker
{
    internal class Account
    {
        private double _accountNumber;
        private int _regNumber;
        private string _accountHolderFirstName;
        private string _accountHolderLastName;
        private byte _accountHolderAge;
        private double _accountBalance;

        private List<Card> _cards;

        private const int _regNumberPrefix = 3520;

        public double AccountNumber { get { return _accountNumber; } }
        public int RegNumber { get { return _regNumber; } }
        public string AccountHolderFirstName { get { return _accountHolderFirstName; } }
        public string AccountHolderLastName { get { return _accountHolderLastName; } }
        public byte AccountHolderAge { get { return _accountHolderAge; } }
        public double AccountBalance { get { return _accountBalance; } }

        public Account(string fName, string lName, byte accountHolderAge)
        {
            _regNumber = _regNumberPrefix;
            _accountNumber = GenerateAccountNumber();
            _cards = new List<Card>();
            _accountHolderFirstName = fName;
            _accountHolderLastName = lName;
            _accountHolderAge = accountHolderAge;
        }

        public Account(string fName, string lName, byte accountHolderAge, double balance)
        {
            _regNumber = _regNumberPrefix;
            _accountNumber = GenerateAccountNumber();
            _cards = new List<Card>();
            _accountHolderFirstName = fName;
            _accountHolderLastName = lName;
            _accountHolderAge = accountHolderAge;
            _accountBalance = 0;
        }

        private double Withdraw(double kr)
        {
            _accountBalance -= kr;
            return _accountBalance;
        }

        private double Deposit(double kr)
        {
            _accountBalance += kr;
            return _accountBalance;
        }

        public double CheckBalance()
        {
            return _accountBalance;
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

        public List<Card> ReturnCards()
        {
            return _cards;
        }

        public void NewCard(string type)
        {
            type = Regex.Replace(type, @"\s", "").ToLower();

            var name = AccountHolderFirstName + " " + AccountHolderLastName;
            switch (type)
            {
                case "hævekort":
                    AddCard(new Hævekort(name));
                    break;

                // over 18
                case "maestro":
                    if (AccountHolderAge >= 18)
                        AddCard(new Maestro(name));
                    break;

                // over 18
                case "mastercard":
                    if (AccountHolderAge >= 18)
                        AddCard(new Mastercard(name));
                    break;

                case "visa":
                    AddCard(new VISA(name));
                    break;

                // over 15
                case "visaelectron":
                    if (AccountHolderAge >= 15)
                        AddCard(new Visa_Electron(name));
                    break;
            }
        }
    }
}
