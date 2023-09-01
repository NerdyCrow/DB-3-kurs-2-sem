using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Lab_4
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }
        string connStr = @"Data Source=.;initial catalog=Personnel; user ID=sa; password=r00t.R00T;";
        DataTable official_inf = new DataTable();
        DataTable personal_inf = new DataTable();
        DataTable vacancy = new DataTable();
        DataTable department = new DataTable();


        // ------------------------------- Table: Official_information ----------------------------
        private void AddOffInf_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                //int idEmployee = Convert.ToInt32(textBoxIdEmployee.Text);
                int personalNum = Convert.ToInt32(textBoxPersonalNum.Text);
                string surname = textBoxSurname.Text;
                string name = textBoxName.Text;
                string patronymic = textBoxPatronymic.Text;
                int idDep = Convert.ToInt32(textBoxIdDep.Text);
                //int idPost = Convert.ToInt32(textBoxIdPost.Text);
                string education = textBoxEducation.Text;
                //int idSpec = Convert.ToInt32(textBoxIdSpec.Text);
                string experience = textBoxExperience.Text;
                string phoneNum = textBoxPhoneNum.Text;
                int salary = Convert.ToInt32(textBoxSalary.Text);
                string status = textBoxStatus.Text;

                DB db = new DB();
                db.openConnection(connStr);
                db.AddOffInf(personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status);
                MessageBox.Show("Done");
                db.closeConnection();
            }
            catch
            {
                MessageBox.Show("The request failed");
            }

        }

        private void DropOffInf_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int idEmployee = Convert.ToInt32(textBoxIdEmployee.Text);
                DB db = new DB();
                db.openConnection(connStr);
                db.DropOffInf(idEmployee);
                MessageBox.Show("Done");
                db.closeConnection();
            }
            catch
            {
                MessageBox.Show("The request failed");
            }
        }

        private void UpdateOffInf_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int idEmployee = Convert.ToInt32(textBoxIdEmployee.Text);
                int personalNum = Convert.ToInt32(textBoxPersonalNum.Text);
                string surname = textBoxSurname.Text;
                string name = textBoxName.Text;
                string patronymic = textBoxPatronymic.Text;
                int idDep = Convert.ToInt32(textBoxIdDep.Text);
                //int idPost = Convert.ToInt32(textBoxIdPost.Text);
                string education = textBoxEducation.Text;
                //int idSpec = Convert.ToInt32(textBoxIdSpec.Text);
                string experience = textBoxExperience.Text;
                string phoneNum = textBoxPhoneNum.Text;
                int salary = Convert.ToInt32(textBoxSalary.Text);
                string status = textBoxStatus.Text;

                if (idEmployee == 0)
                {
                    MessageBox.Show("Check the data");
                }
                else
                {
                    DB db = new DB();
                    db.openConnection(connStr);
                    db.UpdateOffInf(idEmployee, personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status);
                    MessageBox.Show("Done");
                    db.closeConnection();
                }
            }
            catch
            {
                MessageBox.Show("The request failed");
            }

        }

        private void AllOffInf_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "select * from Official_information";
                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    official_inf.Clear();
                    command.Fill(official_inf);
                    OffInfGrid.ItemsSource = official_inf.DefaultView;
                    MessageBox.Show("Done");
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("The request failed");
            }
        }


        // ------------------------------- Table: Personal_information ----------------------------
        private void AddPersInf_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int personalNum = Convert.ToInt32(textBoxpersonalNum.Text);
                string placeBirth = textBoxPlaceBirth.Text;
                string passport = textBoxPassport.Text;
                string address = textBoxAddress.Text;
                string regAddress = textBoxRegAddress.Text;
                string maritalStat = textBoxIdMaritalStat.Text;
                int children = Convert.ToInt32(textBoxRegChildren.Text);
                DateTime dateBirth = Convert.ToDateTime(textBoxDateBirth.Text);

                if (personalNum == 0)
                {
                    MessageBox.Show("Check the data");
                }
                else
                {
                    DB db = new DB();
                    db.openConnection(connStr);
                    db.AddPersInf(personalNum, placeBirth, passport, address, regAddress, maritalStat, children, dateBirth);
                    MessageBox.Show("Done");
                    db.closeConnection();
                }
            }
            catch
            {
                MessageBox.Show("The request failed");
            }
        }

        private void DropPersInf_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int personalNum = Convert.ToInt32(textBoxpersonalNum.Text);

                DB db = new DB();
                db.openConnection(connStr);
                db.DropPersInf(personalNum);
                MessageBox.Show("Done");
                db.closeConnection();
            }
            catch
            {
                MessageBox.Show("The request failed");
            }
        }

        private void UpdatePersInf_Click(object sender, RoutedEventArgs e)
        {
            int personalNum = Convert.ToInt32(textBoxpersonalNum.Text);
            string placeBirth = textBoxPlaceBirth.Text;
            string passport = textBoxPassport.Text;
            string address = textBoxAddress.Text;
            string regAddress = textBoxRegAddress.Text;
            string maritalStat = textBoxIdMaritalStat.Text;
            int children = Convert.ToInt32(textBoxRegChildren.Text);
            string dateBirth = textBoxDateBirth.Text;

            if (personalNum == 0)
            {
                MessageBox.Show("Check the data");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.UpdatePersInf(personalNum, placeBirth, passport, address, regAddress, maritalStat, children, dateBirth);
                MessageBox.Show("Done");
                db.closeConnection();
            }

        }

        private void AllPersInf_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "select * from Personal_information";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    personal_inf.Clear();
                    command.Fill(personal_inf);
                    PersInfGrid.ItemsSource = personal_inf.DefaultView;
                    MessageBox.Show("Done");
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("The request failed");
            }
        }


        // ------------------------------- Table: Vacancy ----------------------------

        private void AddVacancy_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                //int idVacancy= Convert.ToInt32(textBoxIdVacancy.Text);
                int idDep = Convert.ToInt32(textBoxIdDepV.Text);
                //int idPost = Convert.ToInt32(textBoxIdPostV.Text);
                //int idSpec = Convert.ToInt32(textBoxIdSpecV.Text);
                int salary = Convert.ToInt32(textBoxSalaryV.Text);
                string status = comboboxStatusV.Text;

                DB db = new DB();
                db.openConnection(connStr);
                db.AddVacancy(idDep, salary, status);
                MessageBox.Show("Done");
                db.closeConnection();
            }
            catch
            {
                MessageBox.Show("Check the data");
            }
        }

        private void DropVacancy_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int idVacancy = Convert.ToInt32(textBoxIdVacancy.Text);

                DB db = new DB();
                db.openConnection(connStr);
                db.DropVacancy(idVacancy);
                MessageBox.Show("Done");
                db.closeConnection();
            }
            catch
            {
                MessageBox.Show("Check the data");
            }
        }

        private void UpdateVacancy_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int idVacancy = Convert.ToInt32(textBoxIdVacancy.Text);
                int idDep = Convert.ToInt32(textBoxIdDepV.Text);
                //int idPost = Convert.ToInt32(textBoxIdPostV.Text);
                //int idSpec = Convert.ToInt32(textBoxIdSpecV.Text);
                int salary = Convert.ToInt32(textBoxSalaryV.Text);
                string status = comboboxStatusV.Text;

                if (idVacancy == 0)
                {
                    MessageBox.Show("Check the data");
                }
                else
                {
                    DB db = new DB();
                    db.openConnection(connStr);
                    db.UpdateVacancy(idVacancy, idDep, salary, status);
                    MessageBox.Show("Done");
                    db.closeConnection();
                }
            }
            catch
            {
                MessageBox.Show("Check the data");
            }
        }

        public void AllVacancy_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "select * from Vacancy";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    vacancy.Clear();
                    command.Fill(vacancy);
                    VacancyGrid.ItemsSource = vacancy.DefaultView;
                    MessageBox.Show("Done");
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("The request failed");
            }
        }

        // ----------------------------- Available and Unavailable Vacancies ----------------------------

        private void AvailableVacancies_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "select * from AvailableVacancy_view";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    vacancy.Clear();
                    command.Fill(vacancy);
                    VacancyGrid.ItemsSource = vacancy.DefaultView;
                    MessageBox.Show("Done");
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("The request failed");
            }
        }

        private void UnavailableVacancies_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "select * from Vacancy_view";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    vacancy.Clear();
                    command.Fill(vacancy);
                    VacancyGrid.ItemsSource = vacancy.DefaultView;
                    MessageBox.Show("Done");
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("The request failed");
            }
        }

        //private void Button_Click(object sender, RoutedEventArgs e)
        //{
        //}


        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            // STIntersection
                using (var context = new PersonnelEntities())
                {
                    // Load the SQL Server spatial native assemblies
                    SqlServerTypes.Utilities.LoadNativeAssemblies(AppDomain.CurrentDomain.BaseDirectory);

                    // Parse the IDs of the two departments you want to compare
                    var departmentId1 = int.Parse(X.Text);
                    var departmentId2 = int.Parse(Y.Text);

                    // Retrieve the spatial coordinates of the two publishers
                    var department1 = context.Department
                        .Where(d => d.idDep == departmentId1)
                        .Select(d => d.location)
                        .FirstOrDefault();
                    var department2 = context.Department
                        .Where(d => d.idDep == departmentId2)
                        .Select(d => d.location)
                        .FirstOrDefault();

                    // Find the intersection point of the two departments
                    var intersection = department1.Intersection(department2);

                    // Display the intersection point
                    RESULT.Text = intersection != null ? intersection.ToString() : "No intersection";

                }
        }
    }
}
