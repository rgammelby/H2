using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BirdsFlyingAroundApp
{
    internal class Penguin : FlightlessBird
    {
        // has access to Draw() and SetPosition() methods
        // does NOT have access to the SetAltitude() method, as it is not able to fly

        // these methods are not functional, but for the sake of the assignment display relationship between the Penguin class and the FlightlessBird class.
        public override void SetLocation(double longitude, double latitude)
        {
            throw new NotImplementedException();
        }

        public override void Draw()
        {
            base.Draw();
        }
    }
}
