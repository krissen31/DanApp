//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DanApp.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Registration
    {
        public int RegistrationId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Gender { get; set; }
        public byte Age { get; set; }
        public string Country { get; set; }
        public string City { get; set; }
        public string PostCode { get; set; }
        public string UserDescription { get; set; }
        public string FBLink { get; set; }
        public string IGLink { get; set; }
        public string Picture { get; set; }
        public System.DateTime ModifiedDate { get; set; }
    }
}