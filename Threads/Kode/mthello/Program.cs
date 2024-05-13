using System;
using System.Threading;

class Program
{
    static void Main()
    {
        Console.WriteLine("[{0}] Main called", Thread.CurrentThread.ManagedThreadId);
        Console.WriteLine("[{0}] Processor/core count = {1}",
                          Thread.CurrentThread.ManagedThreadId,
                          Environment.ProcessorCount);

        Thread t = new Thread(SayHello);
        t.Name = "Hello Thread";
        t.Priority = ThreadPriority.BelowNormal;
        t.Start();
       //for rækkefølge
        // t.Join();

        Console.WriteLine("[{0}] Main done", Thread.CurrentThread.ManagedThreadId);
    }

    static void SayHello()
    {
        Console.WriteLine("[{0}] Hello, world!", Thread.CurrentThread.ManagedThreadId);
    }
}