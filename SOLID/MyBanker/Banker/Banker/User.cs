using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Banker
{
    internal class User
    {
        private string _firstName;
        private string _lastName;

        public string FirstName { get { return _firstName; } }
        public string LastName { get { return _lastName; } }

        public User(string fName, string lName)
        {
            _firstName = fName;
            _lastName = lName;
        }
    }
}
