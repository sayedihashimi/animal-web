using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Animal.Web
{
    public class AnimalData
    {
        public string Audio { get; set; }
        public string Image { get; set; }
        public string ImageFull { get; set; }
        public string Name { get; set; }

        public static List<AnimalData> GetFromJson(string json)
        {
            return JsonConvert.DeserializeObject<List<AnimalData>>(json);
        }
    }
}
