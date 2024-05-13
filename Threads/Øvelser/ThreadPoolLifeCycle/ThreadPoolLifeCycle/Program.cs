using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace ThreadPoolLifeCycle
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // Instantiate stopwatch
            Stopwatch sw = new Stopwatch();

            // Callout for thread method execution
            Console.WriteLine("Thread Method execution. ");

            // Starts stopwatch
            sw.Start();

            // Calls ProcessWithThreadMethod
            ProcessWithThreadMethod();

            // Callout for elapsed time (ms) for thread method execution
            Console.WriteLine($"Thread Method time elapsed: {sw.Elapsed.TotalMilliseconds} milliseconds. ");

            // Resets stopwatch
            sw.Reset();

            // Callout for thread pool method execution
            // -//-
            Console.WriteLine("Thread Pool execution. ");
            sw.Start();
            ProcessWithThreadPoolMethod();
            sw.Stop();
            Console.WriteLine($"Thread Pool Method time elapsed: {(sw.Elapsed.TotalMilliseconds)} milliseconds. ");

            Console.Read();
        }

        // Iterates through a loop, calls Process 10 times
        static void ProcessWithThreadMethod()
        {
            for (int i = 0; i < 10; i++)
            {
                Thread obj = new Thread(Process);

                obj.Start();
            }
        }

        // -//-
        static void ProcessWithThreadPoolMethod()
        {
            for (int i = 0; i < 10; i++)
            {
                ThreadPool.QueueUserWorkItem(Process);
            }
        }

        // Calls both thread methods
        static void Process(object obj)
        {
            // Empty process
        }

        /* "Skal Process() tage et object som argument? - begrund dit svar
         * I dette tilfælde - ja. Begrundelsen er, at det ikke virker uden. 
         
         Når der indsættes ekstra loops i Process() sker der det, at eksekveringstiden på standard-threads stiger enormt.
        Eksekveringstiden på Thread Pools forbliver dog ca. den samme. */ 
    }
}
