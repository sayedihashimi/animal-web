using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Hosting;
using System.IO;

namespace Animal.Web.Pages {
    public class IndexModel : AnimalBaseModel {
        public IndexModel(IHostingEnvironment hostingEnvironment): base(hostingEnvironment) {

        }
        public void OnGet() {

        }
    }
}
