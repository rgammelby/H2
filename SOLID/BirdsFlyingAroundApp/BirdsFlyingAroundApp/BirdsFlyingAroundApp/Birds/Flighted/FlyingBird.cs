using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BirdsFlyingAroundApp
{
    /// <summary>
    /// The abstract class <c>FlyingBird</c> inherits two methods from its Bird superclass, SetLocation() and Draw(), which are shared with all other birds.
    /// FlyingBird, however, also adds an additional method, SetAltitude(), as it is able to fly, and move on the Y-axis as well. 
    /// Any other characteristics or behaviours unique to flighted birds may be added here.
    /// </summary>
    internal abstract class FlyingBird : Bird
    {
        public abstract void SetAltitude(double altitude);
    }
}
