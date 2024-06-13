using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kaffemaskinen
{
    internal class CoffeeFilter : IFilterHandler
    {
        private byte _coffeeSpoons;

        public CoffeeFilter()
        {
            _coffeeSpoons = 0;
        }

        public byte CoffeeSpoons { get { return _coffeeSpoons; } }

        public bool IsEmpty()
        {
            return _coffeeSpoons <= 0;
        }

        public byte Fill(byte coffee)
        {
            _coffeeSpoons += coffee;
            return _coffeeSpoons;
        }

        public void Empty()
        {
            _coffeeSpoons = 0;
        }

        // added for espresso functionality
        public float Use(int coffeeAmount)
        {
            if (_coffeeSpoons >= coffeeAmount)
            {
                _coffeeSpoons -= (byte)coffeeAmount;
                return 1;
            }

            else
            {
                float val = (float)_coffeeSpoons / coffeeAmount;
                _coffeeSpoons = 0;

                return val;
            }
        }
    }
}
