using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Geometri
{
    internal class Triangle : Shape
    {
        private int _a;
        private int _b;
        // i was i was high on potenuse
        private double _c;

        public Triangle (int a, int b)
        {
            _a = a;
            _b = b;
            _c = Math.Sqrt(Math.Pow(a, 2) + Math.Pow(b, 2));
        }

        new public double CalculateArea()
        {
            return 0.5 * _a * _b;
        }

        new public double CalculatePerimeter()
        {
            return _a + _b + _c;
        }
    }
}
