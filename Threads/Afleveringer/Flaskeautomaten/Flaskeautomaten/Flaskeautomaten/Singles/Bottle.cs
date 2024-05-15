using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Flaskeautomaten
{
    /// <summary>
    /// The Bottle class generates and contains information about each bottle; designation and serial number.
    /// </summary>
    class Bottle
    {
        private List<int> SerialNumbers = new List<int>();

        enum BottleDesignation { Soda, Beer };

        // Bottle designation; beer or soda
        private byte _designation;

        // Serial number
        private int _serial;

        public (byte, int) ReturnBottleInformation()
        {
            return (this._designation, this._serial);
        }

        public string GetDesignation(byte designation)
        {
            BottleDesignation d = (BottleDesignation)designation;
            return d.ToString();
        }

        public Bottle(byte designation)
        {
            _designation = designation;
            _serial = GenerateSerialNumber();
        }

        // Generates a unique serial number for a new bottle
        private int GenerateSerialNumber()
        {
            // Creates a random 5-number serial number
            Random r = new Random();
            var serialNo = r.Next(9999, 99999);

            if (SerialNumbers.Contains(serialNo))
                serialNo = GenerateSerialNumber();
            else
                // Stores created serial numbers in a list
                SerialNumbers.Add(serialNo);

            //debug
            //Console.WriteLine("Unique serial number generated. ");

            return serialNo;
        }
    }
}
