using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Geometri
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Parallelogram p = new Parallelogram(10, 7, 65);
            Console.WriteLine($"Parallelogram\nArea: {p.CalculateArea()}\nPerimeter: {p.CalculatePerimeter()}\n");

            Rectangle r = new Rectangle(5, 8);
            Console.WriteLine($"Rectangle\nArea: {r.CalculateArea()}\nPerimeter: {r.CalculatePerimeter()}\n");

            Trapez t = new Trapez(10, 9, 8);
            Console.WriteLine($"Trapezoid\nArea: {t.CalculateArea().ToString("0.0")}\nPerimeter: {t.CalculatePerimeter()}\n");

            Triangle rt = new Triangle(8, 9);
            Console.WriteLine($"Right Triangle\nArea: {rt.CalculateArea()}\nPerimeter: {rt.CalculatePerimeter()}\n");
            Console.ReadLine();
        }
    }
}
