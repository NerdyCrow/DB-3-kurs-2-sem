//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Laba_2
{
    using System;
    using System.Collections.Generic;
    
    public partial class SUBJECT
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public SUBJECT()
        {
            this.STUDENT_MARK = new HashSet<STUDENT_MARK>();
        }
    
        public string SUBJECT1 { get; set; }
        public string SUBJECT_NAME { get; set; }
        public string PULPIT { get; set; }
    
        public virtual PULPIT PULPIT1 { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<STUDENT_MARK> STUDENT_MARK { get; set; }
    }
}
