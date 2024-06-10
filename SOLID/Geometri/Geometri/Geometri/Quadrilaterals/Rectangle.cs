using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Geometri
{
    internal class Rectangle : Shape
    {
        private int _a;
        private int _b;

        public Rectangle(int a, int b)
        {
            _a = a;
            _b = b;
        }

        new public int CalculateArea()
        {
            return (_a * _b);
        }

        new public int CalculatePerimeter()
        {
            return (_a + _a + _b + _b);
        }

    }
}
