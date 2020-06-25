using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;

namespace AnimalWeb.Shared
{
    public interface IAnimalJsonReader
    {
        List<Animal> GetAnimalsFrom(string jsonString);
        List<Animal> GetAnimalsFromFile(string filepath);
    }

    public class AnimalJsonReader : IAnimalJsonReader
    {
        public List<Animal> GetAnimalsFrom(string jsonString)
        {
            Debug.Assert(jsonString != null);
            return JsonConvert.DeserializeObject<List<Animal>>(jsonString);
        }

        public List<Animal> GetAnimalsFromFile(string filepath)
        {
            Debug.Assert(File.Exists(filepath), $"animals json file not found at {filepath}");
            return GetAnimalsFrom(File.ReadAllText(filepath));
        }
    }
}
