using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Hosting;

namespace Animal.Web.Pages {
    public class SlideshowModel : AnimalBaseModel {
        public SlideshowModel(IHostingEnvironment hostingEnvironment) : base(hostingEnvironment) {

        }
        [BindProperty]
        public int Index { get; set; }
        public void OnGet(int index) {
            Index = index;
        }
    }
}