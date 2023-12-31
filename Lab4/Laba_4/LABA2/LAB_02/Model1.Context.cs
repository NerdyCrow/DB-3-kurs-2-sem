﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace LAB_02
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class PublishingHouseEntities : DbContext
    {
        public PublishingHouseEntities()
            : base("name=PublishingHouseEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Author> Authors { get; set; }
        public virtual DbSet<Book> Books { get; set; }
        public virtual DbSet<Category> Categories { get; set; }
        public virtual DbSet<Distributor> Distributors { get; set; }
        public virtual DbSet<Inventory> Inventories { get; set; }
        public virtual DbSet<Publisher> Publishers { get; set; }
        public virtual DbSet<Sale> Sales { get; set; }
        public virtual DbSet<Books_by_category> Books_by_category { get; set; }
        public virtual DbSet<Books_by_publisher> Books_by_publisher { get; set; }
        public virtual DbSet<BooksWithAuthorsAndCategory> BooksWithAuthorsAndCategories { get; set; }
    
        [DbFunction("PublishingHouseEntities", "fnGetBooksByCategory")]
        public virtual IQueryable<fnGetBooksByCategory_Result> fnGetBooksByCategory(string category_name)
        {
            var category_nameParameter = category_name != null ?
                new ObjectParameter("Category_name", category_name) :
                new ObjectParameter("Category_name", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<fnGetBooksByCategory_Result>("[PublishingHouseEntities].[fnGetBooksByCategory](@Category_name)", category_nameParameter);
        }
    
        public virtual ObjectResult<spGetBooksByCategory_Result> spGetBooksByCategory(string category_name)
        {
            var category_nameParameter = category_name != null ?
                new ObjectParameter("Category_name", category_name) :
                new ObjectParameter("Category_name", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spGetBooksByCategory_Result>("spGetBooksByCategory", category_nameParameter);
        }
    
        public virtual int spUpdateInventory(string iSBN, Nullable<int> copies_in_stock)
        {
            var iSBNParameter = iSBN != null ?
                new ObjectParameter("ISBN", iSBN) :
                new ObjectParameter("ISBN", typeof(string));
    
            var copies_in_stockParameter = copies_in_stock.HasValue ?
                new ObjectParameter("Copies_in_stock", copies_in_stock) :
                new ObjectParameter("Copies_in_stock", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spUpdateInventory", iSBNParameter, copies_in_stockParameter);
        }
    
        public virtual int spUpdateOrders(string iSBN, Nullable<int> copies_ordered)
        {
            var iSBNParameter = iSBN != null ?
                new ObjectParameter("ISBN", iSBN) :
                new ObjectParameter("ISBN", typeof(string));
    
            var copies_orderedParameter = copies_ordered.HasValue ?
                new ObjectParameter("Copies_ordered", copies_ordered) :
                new ObjectParameter("Copies_ordered", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spUpdateOrders", iSBNParameter, copies_orderedParameter);
        }
    
        public virtual int UpdateNotification(string tableName, string recipients, string subject, string body)
        {
            var tableNameParameter = tableName != null ?
                new ObjectParameter("tableName", tableName) :
                new ObjectParameter("tableName", typeof(string));
    
            var recipientsParameter = recipients != null ?
                new ObjectParameter("recipients", recipients) :
                new ObjectParameter("recipients", typeof(string));
    
            var subjectParameter = subject != null ?
                new ObjectParameter("subject", subject) :
                new ObjectParameter("subject", typeof(string));
    
            var bodyParameter = body != null ?
                new ObjectParameter("body", body) :
                new ObjectParameter("body", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("UpdateNotification", tableNameParameter, recipientsParameter, subjectParameter, bodyParameter);
        }
    }
}
