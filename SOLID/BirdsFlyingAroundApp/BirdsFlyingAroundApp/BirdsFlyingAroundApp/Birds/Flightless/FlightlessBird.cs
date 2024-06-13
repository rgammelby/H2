using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BirdsFlyingAroundApp
{
    /// <summary>
    /// The abstract class <c>FlightlessBird</c> inherits two methods from its Bird superclass. These two methods, SetLocation() and Draw() are shared with all other birds;
    /// Flightless or otherwise. This class is left 'alive' if any future additions are needed, adding features unique to flightless birds. 
    /// </summary>
    internal abstract class FlightlessBird : Bird
    {
    }
}
