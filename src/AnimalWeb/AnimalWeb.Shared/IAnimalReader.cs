using System.Collections.Generic;

namespace AnimalWeb.Shared {
    public interface IAnimalReader {
        List<Animal> GetAnimals();
    }
}