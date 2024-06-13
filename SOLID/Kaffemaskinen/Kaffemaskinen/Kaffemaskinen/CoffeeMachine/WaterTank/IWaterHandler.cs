using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kaffemaskinen
{
    public interface IWaterHandler
    {
        // methods for use in a water container
        int Fill(int waterAmount);
        float Use(int waterAmount);
    }
}
