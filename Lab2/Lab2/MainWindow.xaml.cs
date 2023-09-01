using Lab2.models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Microsoft.SqlServer.Types;

namespace Lab2
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {

            using (SqlConnection con = new SqlConnection("Data Source=VICTORY\\VICTORDB;Initial Catalog=SoftLicenseManagement;Integrated Security = SSPI"))
            {
                con.Open();

                try
                {
                    SqlCommand cmd = new SqlCommand("usp_GetLicenses", con);
                    DataTable dataResults = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter adapter1 = new SqlDataAdapter(cmd);
                    adapter1.Fill(dataResults);
                    grid.ItemsSource = dataResults.DefaultView;
                }
                catch (Exception err)
                {
                    Console.WriteLine("ERROR! " + err.Message);
                }

                con.Close();

            }
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            using (SqlConnection con = new SqlConnection("Data Source=VICTORY\\VICTORDB;Initial Catalog=SoftLicenseManagement;Integrated Security = SSPI"))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("usp_AddLicense", con))
                {

                    try
                    {
                        int outparam = 0;
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@title", title.Text);
                        cmd.Parameters.AddWithValue("@expirydate", Convert.ToDateTime(expiredate.Text));
                        cmd.Parameters.AddWithValue("@softwareId", Convert.ToInt32(softwareid.Text));
                        cmd.Parameters.AddWithValue("@customerId", Convert.ToInt32(customerid.Text));
                        cmd.Parameters.AddWithValue("@licenseId", outparam);
                        cmd.ExecuteNonQuery();
                        Console.WriteLine("Insert complete!");
                    }
                    catch (Exception err)
                    {
                        Console.WriteLine("ERROR! " + err.Message);
                       
                    }
                    con.Close();
                }
            }
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            using (SqlConnection con = new SqlConnection("Data Source=VICTORY\\VICTORDB;Initial Catalog=SoftLicenseManagement;Integrated Security = SSPI"))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("usp_DeleteLicense", con))
                {
                    try
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        
                        cmd.Parameters.AddWithValue("@id", Convert.ToInt64(deleteId.Text));
                        cmd.ExecuteNonQuery();
                        Console.WriteLine("Delete complete!");
                    }
                    catch (Exception err)
                    {
                        Console.WriteLine("ERROR! " + err.Message);
                    }
                }
                con.Close();
                }
            }

        private void Button_Click_3(object sender, RoutedEventArgs e)
        {
            using (SqlConnection con = new SqlConnection("Data Source=VICTORY\\VICTORDB;Initial Catalog=SoftLicenseManagement;Integrated Security = SSPI"))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("usp_EditLicense", con))
                {
                    try
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@id", Convert.ToInt64(id.Text));
                        cmd.Parameters.AddWithValue("@title",title.Text);
                        cmd.Parameters.AddWithValue("@expirydate", Convert.ToDateTime(expiredate.Text));
                        cmd.Parameters.AddWithValue("@softwareId", Convert.ToInt32(softwareid.Text));
                        cmd.Parameters.AddWithValue("@customerId", Convert.ToInt32(customerid.Text));
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception err)
                    {
                        Console.WriteLine("ERROR! " + err.Message);
                    }
                }
            }
            }

        private void Button_Click_4(object sender, RoutedEventArgs e)
        {
            using (SqlConnection con = new SqlConnection("Data Source=VICTORY\\VICTORDB;Initial Catalog=SoftLicenseManagement;Integrated Security = SSPI"))
            {
                con.Open();

                try
                {
                    SqlCommand cmd = new SqlCommand("usp_GetLicensesExpireNextMonth", con);
                    DataTable dataResults = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter adapter1 = new SqlDataAdapter(cmd);
                    adapter1.Fill(dataResults);
                    grid.ItemsSource = dataResults.DefaultView;
                }
                catch (Exception err)
                {
                    Console.WriteLine("ERROR! " + err.Message);
                }

                con.Close();

            }
        }

        private void Button_Click_5(object sender, RoutedEventArgs e)
        {
            using (SqlConnection con = new SqlConnection("Data Source=VICTORY\\VICTORDB;Initial Catalog=SoftLicenseManagement;Integrated Security = SSPI"))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("DistanceUser", con))
                {
                    try
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@userID1", Convert.ToInt64(userId1.Text));
                        cmd.Parameters.AddWithValue("@userID2", Convert.ToInt64(userId2.Text));
                        SqlParameter result = new SqlParameter
                        {
                            ParameterName = "@result",
                            SqlDbType = SqlDbType.Float // тип параметра
                        };
                        // указываем, что параметр будет выходным
                        result.Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(result);
                        cmd.ExecuteNonQuery();
                        res.Text = cmd.Parameters["@result"].Value.ToString();
                    }
                    catch (Exception err)
                    {
                        Console.WriteLine("ERROR! " + err.Message);
                    }
                }
                con.Close();

            }
        }

        private void Button_Click_6(object sender, RoutedEventArgs e)
        {
            using (SqlConnection con = new SqlConnection("Data Source=VICTORY\\VICTORDB;Initial Catalog=SoftLicenseManagement;Integrated Security = SSPI"))
            {
                
                con.Open();

                try
                {
                    SqlCommand cmd = new SqlCommand("usp_Cross", con);
                    DataTable dataResults = new DataTable();
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        // Loop through the result set and add each column to the DataTable
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            // Get the name and data type of the current column
                            string columnName = reader.GetName(i);
                            Type columnType = reader.GetFieldType(i);

                            // If the data type is null, use a default data type instead
                            if (columnType == null)
                            {
                                columnType = typeof(string); // or whatever default type you want to use
                            }

                            // Add the column to the DataTable
                            dataResults.Columns.Add(columnName, columnType);
                        }

                        // Loop through the result set again and add each row to the DataTable
                        while (reader.Read())
                        {
                            DataRow row = dataResults.NewRow();
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                row[i] = reader.GetValue(i);
                            }
                            dataResults.Rows.Add(row);
                        }
                    }
                    SqlDataAdapter adapter1 = new SqlDataAdapter(cmd);
                    adapter1.Fill(dataResults);
                    grd2.ItemsSource = dataResults.DefaultView;
                }
                catch (Exception err)
                {
                    Console.WriteLine("ERROR! " + err.Message);
                }

                con.Close();

            }
        }
    }
    
}
