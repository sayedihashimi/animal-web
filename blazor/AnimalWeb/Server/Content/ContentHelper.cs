using Microsoft.AspNetCore.Hosting;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace AnimalWeb.Server.Content
{
    public interface IContentHelper
    {
        string GetAnimalsJsonFilepath();
    }

    public class ContentHelper : IContentHelper
    {
        public ContentHelper(IWebHostEnvironment webHostEnv)
        {
            _webHostEnv = webHostEnv;
        }
        private IWebHostEnvironment _webHostEnv;

        public string GetAnimalsJsonFilepath()
        {
            return Path.Combine(_webHostEnv.ContentRootPath, Strings.AnimalsJsonRelPath);
        }
    }
}
