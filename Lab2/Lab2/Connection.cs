using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace Lab2
{
    class Connection
    {      
        

        static public SqlConnection GetConnection()
        {
            return new SqlConnection("Data Source=VICTORY\\VICTORY;Initial Catalog=SoftLicenseManagement;Integrated Security = SSPI");
        }

      

        static public void CloseConnection(SqlConnection connection)
        {
            connection.Close();
        }

       

    }
}
