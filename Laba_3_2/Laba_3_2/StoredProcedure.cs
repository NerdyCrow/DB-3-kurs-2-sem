using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Laba_3_2
{
    public class StoredProcedure
    {
        
        [Microsoft.SqlServer.Server.SqlProcedure]
        public static void ReadFromFile(string fileName, out SqlString result)
        {
            using (StreamReader reader = new StreamReader(fileName))
            {
                result = reader.ReadToEnd();
            }
        }
    }
    
}



