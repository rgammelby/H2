using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Geometri
{
    public class Shape
    {
        private int _a;

        public Shape() { }

        public Shape(int a)
        {
            _a = a;
        }
        public int CalculateArea()
        {
            return _a * _a;
        }

        public int CalculatePerimeter()
        {
            return _a * 4;
        }
    }
}
