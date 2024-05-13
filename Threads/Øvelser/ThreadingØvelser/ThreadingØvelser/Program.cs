using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace ThreadingØvelser
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // SECOND ASSIGNMENT in worksheet
            //ThreadsFirst tf = new ThreadsFirst();
            //tf.FirstStartThread();

            //Console.Read();

            // THIRD ASSIGNMENT in worksheet
            //ThreadsSecond ts = new ThreadsSecond();
            //ts.CallTempThread();

            // FOURTH ASSIGNMENT in worksheet
            ThreadsThird tt = new ThreadsThird();
            tt.Menu();

            //Console.WriteLine("Thread terminated. ");
            //Console.Read();
        }
    }

    // Belongs to the SECOND ASSIGNMENT in worksheet
    class ThreadsFirst
    {
        public void FirstStartThread()
        {
            // Instantiates threads
            Thread t = new Thread(new ThreadStart(FirstThread));
            Thread t2 = new Thread(new ThreadStart(Secondthread));

            // Starts threads
            t.Start();
            t2.Start();
        }

        // First Thread Method belonging to 2nd assignment
        public void FirstThread()
        {
            for (int i = 0; i < 5; i++)
            {
                Console.WriteLine("C#-trådning er nemt! ");
                Thread.Sleep(1000);
            }
        }

        // Second Thread Method belonging to 2nd assignment
        public void Secondthread()
        {
            for (int i = 0; i < 5; i++)
            {
                Console.WriteLine("Også med flere tråde... ");
                Thread.Sleep(1000);
            }
        }
    }

    // Belongs to the THIRD ASSIGNMENT in worksheet
    class ThreadsSecond
    {
        public bool IsRunning;

        public void TempThread()
        {
            const byte MINTEMP = 0;
            const byte MAXTEMP = 100;

            var alarmCount = 0;

            while (alarmCount < 3)
            {
                var tr = new Random();
                var temp = tr.Next(-20, 120);

                Console.WriteLine($"Temperature: {temp} degrees C. ");

                if (temp < MINTEMP || temp > MAXTEMP)
                {
                    Console.WriteLine("Warning! Extreme temperature variance detected. ");
                    alarmCount++;
                }

                Thread.Sleep(2000);
            }

            IsRunning = false;
        }

        public void CallTempThread()
        {
            Thread t = new Thread(new ThreadStart(TempThread));
            t.Start();
            IsRunning = true;

            while(true)
            {
                if (IsRunning)
                {
                    Console.WriteLine("The thread lives. ");
                }

                else if (!IsRunning)
                {
                    Console.WriteLine("The thread has been terminated due to alarm callouts. ");
                    return;
                }

                Thread.Sleep(10000);
            }
        }
    }

    // Belongs to the FOURTH ASSIGNMENT in worksheet
    class ThreadsThird
    {
        public char UserInput;

        public void Menu()
        {
            // Prompts the user to begin
            Console.WriteLine("Press 'Enter' to begin. ");

            // Reads user input
            ConsoleKeyInfo cki = Console.ReadKey();

            // If user has pressed 'Enter', the threads will be called
            if (cki.Key == ConsoleKey.Enter)
                CallThreads();
        }

        // Detects user input
        public void InputThread()
        {
            while (true)
            {
                // Sets scope var UserInput = the key the user has pressed
                ConsoleKeyInfo input = Console.ReadKey();
                UserInput = input.KeyChar;
            }
        }

        // Handles output
        public void OutputThread()
        {
            // If user inputs nothing, print asterisk
            const char DEFAULT = '*';

            while(true)
            {
                // If var UserInput not empty (may contain spaces)
                if (UserInput != '\0')
                {
                    // UserInput continuous print
                    Console.Write(UserInput);
                    Thread.Sleep(200);
                }
                else
                {
                    // Default (asterisk) continuous print
                    Console.Write(DEFAULT);
                    Thread.Sleep(200);
                }
            }
        }

        public void CallThreads()
        {
            // Tells user how to exit
            Console.CursorLeft = 0; Console.CursorTop = 0;
            Console.WriteLine("Press Ctrl + C to EXIT. ");

            // Instantiates threads
            Thread it = new Thread(new ThreadStart(InputThread));
            Thread ot = new Thread(new ThreadStart(OutputThread));

            // Starts both threads
            it.Start();
            ot.Start();
        }
    }
}
