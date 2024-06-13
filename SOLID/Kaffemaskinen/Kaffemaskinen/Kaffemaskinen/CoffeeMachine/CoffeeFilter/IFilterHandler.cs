using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kaffemaskinen
{
    public interface IFilterHandler
    {
        byte Fill(byte coffeeSpoons);

        void Empty();

        // added for espresso functionality
        float Use(int waterAmount);
    }
}
