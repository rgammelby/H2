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
    }
}
