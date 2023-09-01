using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lab_4
{
    class DB
    {
        SqlConnection conn;
        public void openConnection(string connStr)
        {
            conn = new SqlConnection(connStr);
            conn.Open();
        }
        public void closeConnection()
        {
            conn.Close();
        }


        // ------------------------------- Table: Official_information ----------------------------
        public void AddOffInf(int personalNum, string surname, string name, string patronymic, int idDep, string education, string experience, string phoneNum, int salary, string status)
        {
            SqlCommand cmd = new SqlCommand("Add_Official_Inf_Proc", conn)
            {
                CommandType = System.Data.CommandType.StoredProcedure
            };
            //cmd.Parameters.Add("IdEmployee", sqlDbType: SqlDbType.Int).Value = idEmployee;
            cmd.Parameters.Add("personalNum", sqlDbType: SqlDbType.Int).Value = personalNum;
            cmd.Parameters.Add("Surname", sqlDbType: SqlDbType.NVarChar).Value = surname;
            cmd.Parameters.Add("Name", sqlDbType: SqlDbType.NVarChar).Value = name;
            cmd.Parameters.Add("Patronymic", sqlDbType: SqlDbType.NVarChar).Value = patronymic;
            cmd.Parameters.Add("IdDep", sqlDbType: SqlDbType.Int).Value = idDep;
            //cmd.Parameters.Add("IdPost", sqlDbType: SqlDbType.Int).Value = idPost;
            cmd.Parameters.Add("Education", sqlDbType: SqlDbType.NVarChar).Value = education;
            //cmd.Parameters.Add("IdSpec", sqlDbType: SqlDbType.Int).Value = idSpec;
            cmd.Parameters.Add("Experience", sqlDbType: SqlDbType.NVarChar).Value = experience;
            cmd.Parameters.Add("PhoneNum", sqlDbType: SqlDbType.NVarChar).Value = phoneNum;
            cmd.Parameters.Add("Salary", sqlDbType: SqlDbType.Int).Value = salary;
            cmd.Parameters.Add("Status", sqlDbType: SqlDbType.NVarChar).Value = status;
            cmd.ExecuteNonQuery();
        }

        public void DropOffInf(int idEmployee)
        {
            SqlCommand cmd = new SqlCommand("Delete_Official_Inf_Proc", conn)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.Add("IdEmployee", sqlDbType: SqlDbType.Int).Value = idEmployee;
            cmd.ExecuteNonQuery();
        }

        public void UpdateOffInf(int idEmployee, int personalNum, string surname, string name, string patronymic, int idDep, string education, string experience, string phoneNum, int salary, string status)
        {
            SqlCommand cmd = new SqlCommand("Update_Official_Inf_Proc", conn)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.Add("IdEmployee", sqlDbType: SqlDbType.Int).Value = idEmployee;
            cmd.Parameters.Add("personalNum", sqlDbType: SqlDbType.Int).Value = personalNum;
            cmd.Parameters.Add("Surname", sqlDbType: SqlDbType.NVarChar).Value = surname;
            cmd.Parameters.Add("Name", sqlDbType: SqlDbType.NVarChar).Value = name;
            cmd.Parameters.Add("Patronymic", sqlDbType: SqlDbType.NVarChar).Value = patronymic;
            cmd.Parameters.Add("IdDep", sqlDbType: SqlDbType.Int).Value = idDep;
            //cmd.Parameters.Add("IdPost", sqlDbType: SqlDbType.Int).Value = idPost;
            cmd.Parameters.Add("Education", sqlDbType: SqlDbType.NVarChar).Value = education;
            //cmd.Parameters.Add("IdSpec", sqlDbType: SqlDbType.Int).Value = idSpec;
            cmd.Parameters.Add("Experience", sqlDbType: SqlDbType.NVarChar).Value = experience;
            cmd.Parameters.Add("PhoneNum", sqlDbType: SqlDbType.NVarChar).Value = phoneNum;
            cmd.Parameters.Add("Salary", sqlDbType: SqlDbType.Int).Value = salary;
            cmd.Parameters.Add("Status", sqlDbType: SqlDbType.NVarChar).Value = status;
            cmd.ExecuteNonQuery();
        }

        // ---------------------------- Table: Personal_information ------------------------------
        public void AddPersInf(int personalNum, string placeBirth, string passport, string address, string regAddress, string maritalStat, int children, DateTime dateBirth)
        {
            SqlCommand cmd = new SqlCommand("Add_Personal_Inf_Proc", conn)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.Add("PersonalNum", sqlDbType: SqlDbType.Int).Value = personalNum;
            cmd.Parameters.Add("PlaceBirth", sqlDbType: SqlDbType.NVarChar).Value = placeBirth;
            cmd.Parameters.Add("Passport", sqlDbType: SqlDbType.NVarChar).Value = passport;
            cmd.Parameters.Add("Address", sqlDbType: SqlDbType.NVarChar).Value = address;
            cmd.Parameters.Add("RegAddress", sqlDbType: SqlDbType.NVarChar).Value = regAddress;
            cmd.Parameters.Add("MaritalStat", sqlDbType: SqlDbType.NVarChar).Value = maritalStat;
            cmd.Parameters.Add("Children", sqlDbType: SqlDbType.Int).Value = children;
            cmd.Parameters.Add("DateBirth", sqlDbType: SqlDbType.NVarChar).Value = dateBirth;
            cmd.ExecuteNonQuery();
        }

        public void DropPersInf(int personalNum)
        {
            SqlCommand cmd = new SqlCommand("Delete_Personal_Inf_Proc", conn)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.Add("PersonalNum", sqlDbType: SqlDbType.Int).Value = personalNum;
            cmd.ExecuteNonQuery();
        }

        public void UpdatePersInf(int personalNum, string placeBirth, string passport, string address, string regAddress, string maritalStat, int children, string dateBirth)
        {
            SqlCommand cmd = new SqlCommand("Update_Personal_Inf_Proc", conn)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.Add("PersonalNum", sqlDbType: SqlDbType.Int).Value = personalNum;
            cmd.Parameters.Add("PlaceBirth", sqlDbType: SqlDbType.NVarChar).Value = placeBirth;
            cmd.Parameters.Add("Passport", sqlDbType: SqlDbType.NVarChar).Value = passport;
            cmd.Parameters.Add("Address", sqlDbType: SqlDbType.NVarChar).Value = address;
            cmd.Parameters.Add("RegAddress", sqlDbType: SqlDbType.NVarChar).Value = regAddress;
            cmd.Parameters.Add("MaritalStat", sqlDbType: SqlDbType.NVarChar).Value = maritalStat;
            cmd.Parameters.Add("Children", sqlDbType: SqlDbType.Int).Value = children;
            cmd.Parameters.Add("DateBirth", sqlDbType: SqlDbType.NVarChar).Value = dateBirth;
            cmd.ExecuteNonQuery();
        }


        // ---------------------------------- Table: Vacancy -------------------------------------
        public void AddVacancy(int idDep, int salary, string status)
        {
            SqlCommand cmd = new SqlCommand("Add_Vacancy_Proc", conn)
            {
                CommandType = CommandType.StoredProcedure
            };
            //cmd.Parameters.Add("IdVacancy", sqlDbType: SqlDbType.Int).Value = idVacancy;
            cmd.Parameters.Add("IdDep", sqlDbType: SqlDbType.Int).Value = idDep;
            //cmd.Parameters.Add("IdPost", sqlDbType: SqlDbType.Int).Value = idPost;
            //cmd.Parameters.Add("IdSpec", sqlDbType: SqlDbType.Int).Value = idSpec;
            cmd.Parameters.Add("Salary", sqlDbType: SqlDbType.Int).Value = salary;
            cmd.Parameters.Add("Status", sqlDbType: SqlDbType.NVarChar).Value = status;
            cmd.ExecuteNonQuery();
        }

        public void DropVacancy(int idVacancy)
        {
            SqlCommand cmd = new SqlCommand("Delete_Vacancy_Proc", conn)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.Add("IdVacancy", sqlDbType: SqlDbType.Int).Value = idVacancy;
            cmd.ExecuteNonQuery();
        }

        public void UpdateVacancy(int idVacancy, int idDep, int salary, string status)
        {
            SqlCommand cmd = new SqlCommand("Update_Vacancy_Proc", conn)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.Add("IdVacancy", sqlDbType: SqlDbType.Int).Value = idVacancy;
            cmd.Parameters.Add("IdDep", sqlDbType: SqlDbType.Int).Value = idDep;
            //cmd.Parameters.Add("IdPost", sqlDbType: SqlDbType.Int).Value = idPost;
            //cmd.Parameters.Add("IdSpec", sqlDbType: SqlDbType.Int).Value = idSpec;
            cmd.Parameters.Add("Salary", sqlDbType: SqlDbType.Int).Value = salary;
            cmd.Parameters.Add("Status", sqlDbType: SqlDbType.NVarChar).Value = status;
            cmd.ExecuteNonQuery();
        }

        public void AvailableVacancies()
        {
            SqlCommand cmd = new SqlCommand("AvailableVacancy_view", conn)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.ExecuteNonQuery();
        }
    }
}