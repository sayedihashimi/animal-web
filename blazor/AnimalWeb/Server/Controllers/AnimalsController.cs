using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AnimalWeb.Server.Content;
using AnimalWeb.Shared;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using AnimalWeb.Shared.Extensions;

namespace AnimalWeb.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AnimalsController : ControllerBase
    {
        public AnimalsController(IAnimalJsonReader animalReader, IContentHelper contentHelper)
        {
            _animalJsonReader = animalReader;
            _contentHelper = contentHelper;
            _animals = _animalJsonReader.GetAnimalsFromFile(_contentHelper.GetAnimalsJsonFilepath());
        }
        private IAnimalJsonReader _animalJsonReader;
        private IContentHelper _contentHelper;
        private readonly List<Animal> _animals;
        public List<Animal> Get()
        {
            return _animals.Clone();
        }
    }
}
