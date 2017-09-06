using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Hosting;

namespace Animal.Web.Pages {
    public class SlidesModel : AnimalBaseModel {
        public SlidesModel(IHostingEnvironment hostingEnvironment) : base(hostingEnvironment) {

        }
        [BindProperty]
        public int Index { get; set; }

        public int NextIndex { get; set; }
        public int PreviousIndex { get; set; }
        public void OnGet(int index) {
            if(index < 0 && Animals != null) {
                index = Animals.Count - 1;
            }
            Index = index;

            PreviousIndex = Index - 1;
            NextIndex = Index + 1;

            // ensure PreviousIndex in range
            if(Animals != null && PreviousIndex < 0) {
                PreviousIndex = Animals.Count - 1;
            }
            if (Animals != null && PreviousIndex >= Animals.Count) {
                // shouldn't happen
                PreviousIndex = 0;
            }

            // ensure NextIndex in range
            if (Animals != null && NextIndex >= Animals.Count) {
                NextIndex = 0;
            }
            if (Animals != null && NextIndex < 0) {
                // shouldn't happen
                NextIndex = Animals.Count - 1;
            }
        }
    }
}