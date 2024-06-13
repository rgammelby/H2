using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kaffemaskinen
{
    internal class CoffeeMachine : IBrew
    {
        private WaterContainer _waterContainer;
        private CoffeeFilter _coffeeFilter;

        private const byte MILLILITRES_PER_CUP = 100;
        private const byte COFFEE_SPOONS_PER_CUP = 1;

        public CoffeeMachine(int waterVolume)
        {
            _waterContainer = new WaterContainer(waterVolume);
            _coffeeFilter = new CoffeeFilter();
        }

        public WaterContainer WaterContainer { get { return _waterContainer; } }
        public CoffeeFilter Filter { get { return _coffeeFilter; } }

        public float Brew()
        {
            float cups = 0;

            // runs while the water tank is not empty
            while (!_waterContainer.IsEmpty())
            {
                // uses 1 cup (100 mL) worth of water
                cups += _waterContainer.Use(MILLILITRES_PER_CUP);
            }

            // empties the coffee filter when the brewing process is finished
            _coffeeFilter.Empty();

            // return final cup amount readout
            return cups;
        }
    }
}
