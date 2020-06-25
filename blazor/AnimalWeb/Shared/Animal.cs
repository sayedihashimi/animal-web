using System;
using System.Collections.Generic;
using System.Text;

namespace AnimalWeb.Shared
{
    public interface IAnimal : ICloneable
    {
        string Audio { get; set; }
        string Id { get; set; }
        string Image { get; set; }
        string ImageFull { get; set; }
        string Name { get; set; }
    }

    public class Animal : IAnimal
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string ImageFull { get; set; }
        public string Image { get; set; }
        public string Audio { get; set; }

        public object Clone()
        {
            return new Animal
            {
                Id = Id,
                Audio = Audio,
                Image = Image,
                ImageFull = ImageFull,
                Name = Name
            };
            throw new NotImplementedException();
        }
    }
}
