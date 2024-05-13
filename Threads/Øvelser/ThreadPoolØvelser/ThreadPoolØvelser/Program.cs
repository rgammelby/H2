using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace ThreadPoolØvelser
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // Instantiates ThreadPoolDemo
            ThreadPoolDemo tpd = new ThreadPoolDemo();

            // Queues both ThreadPoolDemo threads twice
            for (int i = 0; i <= 2; i++)
            {
                ThreadPool.QueueUserWorkItem(new WaitCallback(tpd.TaskOne));
                ThreadPool.QueueUserWorkItem(new WaitCallback(tpd.TaskTwo));
            }

            Console.Read();
        }
    }
    class ThreadPoolDemo
    {
        // Taks 1
        public void TaskOne(object obj)
        {
            // Prints task 1 callout twice
            for (int i = 0; i <= 2; i++)
            {
                Console.WriteLine("Task 1 is being executed. ");
            }
        }

        // Task 2
        public void TaskTwo(object obj)
        {
            // Prints task 2 callout twice
            for(int i = 0; i <= 2; i++)
            {
                Console.WriteLine("Task 2 is being executed. ");
            }
        }
    }
}
