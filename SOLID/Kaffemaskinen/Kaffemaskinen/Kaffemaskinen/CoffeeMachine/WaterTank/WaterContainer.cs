using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kaffemaskinen
{
    internal class WaterContainer : IWaterHandler
    {
        // volume of water contained within the water tank - as well as tank's maximum volume, tbd in constructor
        private int _volume;
        private readonly int MAXIMUM_VOLUME;

        public WaterContainer(int waterVolume)
        {
            _volume = 0;
            MAXIMUM_VOLUME = waterVolume;
        }

        public int Volume { get { return _volume; } }

        // used to check whether the coffee machine should continue brewing
        public bool IsEmpty()
        {
            return _volume <= 0;
        }

        // used to set initial water amount for a pot of coffee
        public int Fill(int waterAmount)
        {
            if (waterAmount >= MAXIMUM_VOLUME)
            {
                _volume = MAXIMUM_VOLUME;
            }

            else
            {
                _volume += waterAmount;
            }

            return _volume;
        }

        // decreases the amount of water in the tank and returns cups brewed
        public float Use(int waterAmount)
        {
            if (_volume >= waterAmount)
            {
                _volume -= waterAmount;
                return 1;
            }

            else
            {
                float val = (float)_volume / waterAmount;
                _volume = 0;

                return val;
            }
        }
    }
}
