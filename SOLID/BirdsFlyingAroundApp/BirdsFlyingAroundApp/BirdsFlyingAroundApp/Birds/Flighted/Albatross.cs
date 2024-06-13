using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BirdsFlyingAroundApp
{
    internal class Albatross : FlyingBird
    {
        // has access to Draw() and SetPosition() methods like any other bird
        // DOES have access to the SetAltitude() method, as it is able to fly, eg. move on the y-axis as well, as opposed to flightless birds

        // these methods are not functional, but for the sake of the assignment display relationship between the Albatross class and the FlyingBird class.
        public override void SetLocation(double longitude, double latitude)
        {
            throw new NotImplementedException();
        }

        public override void SetAltitude(double altitude)
        {
            throw new NotImplementedException();
        }

        public override void Draw()
        {
            base.Draw();
        }
    }
}
