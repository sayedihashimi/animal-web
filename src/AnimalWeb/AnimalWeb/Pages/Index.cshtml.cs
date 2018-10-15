using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using AnimalWeb.Shared;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace AnimalWeb.Pages {
    public class IndexModel : PageModel {
        public IndexModel(IAnimalReader animalReader) {
            AnimalReader = animalReader;
        }

        public IAnimalReader AnimalReader { get; }

        public List<Animal> Animals {
            get;
            set;
        }

        public List<string>GetImagesFor(Animal animal) {
            var result = new List<string>();

            var sizes = new int[]{ 640, 768, 1024, 1366, 1600, 1920, };

            foreach(var size in sizes) {
                FileInfo fi = new FileInfo(animal.ImageFull);
                string basename = fi.Name.Substring(0, fi.Name.Length - fi.Extension.Length);
                result.Add($"{basename}-{size}px{fi.Extension}");
            }

            return result;
        }

        public void OnGet() {
            // get all the animals
            try {
                Animals = AnimalReader.GetAnimals();
            }
            catch(Exception ex) {
                System.Console.WriteLine(ex.ToString());
            }
        }
    }
}
