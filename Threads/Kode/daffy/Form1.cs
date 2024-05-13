using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading;

namespace daffy
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Thread t = new Thread(DoLongOperation);
            t.Start();
            //Thread.Sleep(5000);
        }

        void DoLongOperation()
        {
            Thread.Sleep(5000);
        }
    }
}
