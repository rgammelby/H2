using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Geometri
{
    internal class Trapez : Shape
    {
        // bundlinje
        private int _a;
        // sidelængde
        private int _b;
        // toplinje
        private int _c;
        // height
        private double _h;

        public Trapez(int a, int b, int c)
        {
            _a = a;
            _b = b;
            _c = c;
            _h = CalculateHeight();
        }

        public double CalculateHeight()
        {
            var s = (_a + _b - _c + _b) / 2;

            var h = 2 / (_a - _c) * Math.Sqrt(s * (s - _a + _c) * (s - _b) * (s - _b));

            return h;
        }

        new public double CalculateArea()
        {
            return 0.5 * (_a + _c) * _h;
        }

        new public int CalculatePerimeter()
        {
            return _a + _c + (_b * 2);
        }
    }
}
