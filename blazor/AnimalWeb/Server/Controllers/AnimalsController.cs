using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AnimalWeb.Server.Content;
using AnimalWeb.Shared;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using AnimalWeb.Shared.Extensions;
using System.Reflection.Metadata.Ecma335;

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

        [Route("")]
        public List<Animal> Get()
        {
            return _animals.Clone();
        }

        [Route("{id?}")]
        public Animal Get(string id)
        {
            return _animals.SingleOrDefault<Animal>((a) => string.Equals(id, a.Id));
        }
    }
}
