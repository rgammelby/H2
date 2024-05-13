using System;
using System.Threading;

class Program
{
    static void Main()
    {
        Console.WriteLine("[{0}] Main called", Thread.CurrentThread.ManagedThreadId);

        for (int n = 0; n < 10; n++)
        {
            ThreadPool.QueueUserWorkItem(SayHello, n);
        }

        Thread.Sleep(rng.Next(1000, 3000));
        Console.WriteLine("[{0}] Main done", Thread.CurrentThread.ManagedThreadId);
    }

    static Random rng = new Random();

    static void SayHello(object arg)
    {
        Thread.Sleep(rng.Next(250, 500));

        int n = (int)arg;

        Console.WriteLine("[{0}] Hello, world {1}! ({2})",
                          Thread.CurrentThread.ManagedThreadId,
                          n,
                          Thread.CurrentThread.IsBackground);
    }
}