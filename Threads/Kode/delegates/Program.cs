using System;
using System.Threading;

delegate void BinaryOperation(int x, int y);

class Program
{
    static void Main()
    {
        Console.WriteLine("[{0}] Main called", Thread.CurrentThread.ManagedThreadId);

#if (false)
        Add(2, 2);
#else
        BinaryOperation asyncAdd = Add;
        asyncAdd.BeginInvoke(2, 2, null, null);
        Thread.Sleep(1000);
#endif

        Console.WriteLine("[{0}] Main done", Thread.CurrentThread.ManagedThreadId);
    }

    static void Add(int a, int b)
    {
        Console.WriteLine("[{0}] Add({1}, {2}) => {3}",
                          Thread.CurrentThread.ManagedThreadId,
                          a, b, (a + b));
    }
}
