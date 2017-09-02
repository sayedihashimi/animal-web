using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Hosting;
using System.IO;

namespace Animal.Web.Pages {
    public class IndexModel : PageModel {

        public IndexModel(IHostingEnvironment hostingEnvironment) : base() {
            _hostingEnvironment = hostingEnvironment;
            _webRoot = _hostingEnvironment.WebRootPath;
            SetFilepath("animals.json");
        }
        private IHostingEnvironment _hostingEnvironment;
        private static string _webRoot { get; set; }
        private static string Filepath { get; set; }
        private static List<AnimalData> Animals { get; set; }
        public static void SetFilepath(string filename) {
            string filepath = Path.Combine(_webRoot, filename);
            Filepath = filepath;
        }

        public List<AnimalData> AnimalList { get; set; }
        public void OnGet() {
            if (Animals == null) {
                lock (Filepath) {
                    Animals = AnimalData.GetFromJson(System.IO.File.ReadAllText(Filepath));
                }
            }

            this.AnimalList = Animals;
        }
    }
}
