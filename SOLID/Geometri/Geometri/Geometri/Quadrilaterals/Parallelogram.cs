using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Geometri
{
    internal class Parallelogram : Shape
    {
        private int _a;
        private int _b;
        private int _v;

        public Parallelogram(int a, int b, int v)
        {
            _a = a;
            _b = b;
            _v = v;
        }

        new public double CalculateArea()
        {
            return _a * _b * Math.Sin(_v);
        }

        new public int CalculatePerimeter()
        {
            return ((_a * 2) + (_b * 2));
        }
    }
}
