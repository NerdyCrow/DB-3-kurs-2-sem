using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lab2.models
{
    public class License
    {
        public String Title { get; set; }
        public String PaymentDate { get; set; }
        public String ExpiryDate { get; set; }
        public int SoftwareId { get; set; }
        public int CustomerId { get; set; }

        public License(String title, String paymentDate, String expiryDate, int softwareId, int customerId)
        {
            this.Title = title;
            this.PaymentDate = paymentDate;
            this.ExpiryDate = expiryDate;
            this.SoftwareId = softwareId;
            this.CustomerId = customerId;
        }
    }
}
