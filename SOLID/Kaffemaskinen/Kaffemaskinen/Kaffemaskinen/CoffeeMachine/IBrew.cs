using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kaffemaskinen
{
    public interface IBrew
    {
        float Brew();
        float BrewEspresso();
    }
}
