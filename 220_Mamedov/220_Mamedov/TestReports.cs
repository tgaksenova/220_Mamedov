//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace _220_Mamedov
{
    using System;
    using System.Collections.Generic;
    
    public partial class TestReports
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public TestReports()
        {
            this.TestQuestion = new HashSet<TestQuestion>();
        }
    
        public int Id { get; set; }
        public Nullable<System.DateTime> TestDate { get; set; }
        public Nullable<int> StudentID { get; set; }
    
        public virtual Students Students { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TestQuestion> TestQuestion { get; set; }
    }
}
