using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lab2.models
{
    public class Software
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Version { get; set; }
        public float Price { get; set; }
        public int OwnerId { get; set; }
        public string DateCreation { get; set; }

        public Software(int iD, string name, string version, float price, int ownerId, string dateCreation)
        {
            ID = iD;
            Name = name;
            Version = version;
            Price = price;
            OwnerId = ownerId;
            DateCreation = dateCreation;
        }
    }
}
