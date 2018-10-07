using System;
using System.Collections.Generic;
using System.IO;
using Newtonsoft.Json;

namespace AnimalWeb.Shared {
    public class AnimalJsonReader : IAnimalReader {
        public AnimalJsonReader(string pathToJsonFile) {
            PathToJsonFile = pathToJsonFile;
        }

        public string PathToJsonFile {
            get;
            private set;
        }

        public List<Animal> GetAnimals() {
            if (!File.Exists(PathToJsonFile)) {
                throw new FileNotFoundException($"Animals JSON file not found at {PathToJsonFile}", PathToJsonFile);
            }

            string jsonContents = File.ReadAllText(PathToJsonFile);
            return JsonConvert.DeserializeObject<List<Animal>>(jsonContents);
        }


    }
}
