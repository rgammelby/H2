using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace BirdsFlyingAroundApp
{
    internal class Program
    {
        /// <summary>
        /// Man kunne argumentere for, at pingviner ikke ville høre til i en 'BirdsFlyingAroundApp', men for at imødekomme ønsket om at rette i Peters kode,
        ///har jeg i stedet for at slette pingvinen valgt at tilføje et ekstra led i arvehierarkiet.

        ///Den tidligere 'Bird' superklasse er nu lavet om til en 'FlyingBird' klasse.På samme plads i hierarkiet er der nu også implementeret en 'FlightlessBird' klasse,
        ///som indeholder f.eks.pingvinen og evt.kiwier, eller hvad Peter nu finder på i fremtiden.
        
        ///'FlyingBird' og 'FlightlessBird' arver begge fra en ny 'Bird' superklasse.

        ///Den nye 'Bird' superklasse indeholder de to abstrakte metoder 'SetLocation' og 'Draw'.

        ///Kun 'FlightlessBird' klassen indeholder 'SetAltitude'-metoden.
        /// </summary>
        /// <param name="args"></param>
        static void Main(string[] args)
        {
        }
    }
}
