using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BirdsFlyingAroundApp
{
    internal abstract class Bird
    {
        public abstract void SetLocation(double longitude, double latitude);
        public virtual void Draw() { }
    }
}
