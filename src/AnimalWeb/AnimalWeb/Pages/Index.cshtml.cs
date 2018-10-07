using System;
using System.Collections.Generic;
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
