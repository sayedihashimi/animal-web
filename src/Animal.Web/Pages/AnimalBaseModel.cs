using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace Animal.Web.Pages
{
    public class AnimalBaseModel : PageModel {
        public AnimalBaseModel(IHostingEnvironment hostingEnvironment) : base() {
            _hostingEnvironment = hostingEnvironment;
            _webRoot = _hostingEnvironment.WebRootPath;
            SetFilepath("animals.json");
        }
        private IHostingEnvironment _hostingEnvironment;
        public string _webRoot { get; set; }
        public string Filepath { get; set; }
        public List<AnimalData> Animals { get; set; }
        public void SetFilepath(string filename) {
            string filepath = Path.Combine(_webRoot, filename);
            Filepath = filepath;
            Animals = AnimalData.GetFromJson(System.IO.File.ReadAllText(Filepath));
        }
    }
}
