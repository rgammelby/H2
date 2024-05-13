using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Threading
{
    internal class Program
    {
        // WorkThreadFunction prints function name and number for each logical processor available.
        public void WorkThreadFunction()
        {
            for (int i = 0; i < Environment.ProcessorCount; i++)
            {
                Console.WriteLine("WorkThreadFunction: " + i);
            }
        }

        // -//-
        public void SecondThreadFunction()
        {
            for (int i = 0; i < Environment.ProcessorCount;i++)
            {
                Console.WriteLine("SecondThreadFunction: " + i);
            }
        }
    }

    // As per the material, the Main-method is now contained in the class 'ThreadProgram'.
    class ThreadProgram
    {
        static void Main(string[] args)
        {
            // Creates an instance of the 'Program' class.
            Program p = new Program();

            // Creates an instance of a thread; 'thread'. This is a Parameterized Thread, which takes the output of the for loop in the WorkThreadFunction as a parameter.
            Thread thread = new Thread(new ThreadStart(p.WorkThreadFunction));

            // Creates a second thread; -//-
            Thread secondThread = new Thread(new ThreadStart(p.SecondThreadFunction));

            // Starts the threads.
            thread.Start();
            secondThread.Start();

            // Stops the program / waits for user input.
            Console.ReadLine();
        }
    }
}
