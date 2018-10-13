
// https://www.webstoemp.com/blog/responsive-images-pipeline-with-gulp/
const del = require("del");
const gulp = require("gulp");
const deleteEmpty = require("delete-empty");
const globby = require("globby");
const gulpImagemin = require("gulp-imagemin");
const gulpImageresize = require("gulp-image-resize");
const gulpNewer = require("gulp-newer");
const merge2 = require("merge2");
var rename = require("gulp-rename");

const srcFolder = "./media-src/";
const destFolder = "./wwwroot/media-test-dist/";

gulp.task("sih:updateimages",["sih:optimizeimages"], () => {
    // TODO
});

gulp.task("sih:optimizeimages",()=> {
    return gulp.src([destFolder + "*.jpg",destFolder + "*.png"], { nodir: false })
        .pipe(gulpImagemin({
                progressive: true,
                svgoPlugins: [{ removeViewBox: false }, { removeUselessStrokeAndFill: false }]
                }))
        .pipe(gulp.dest(destFolder));
});

gulp.task("sih:makethumbnails", () => {
    const streams=[];
    streams.push(gulp.src([srcFolder + "*.jpg",srcFolder + "*.png"], {nodir: true})
                /*.pipe(gulpNewer(destFolder+"thumbs_"+'768px'))*/
                .pipe(gulpImageresize({
                    imageMagick: true,
                    width: 768,
                    crop: false
                    }))
                .pipe(gulpImagemin({
                    progressive: true,
                    svgoPlugins:[{removeViewBox: false},{removeUselessStrokeAndFill: false}]
                    }))
            .pipe(rename(function(path){
                path.basename += "-768px"
            }))
            .pipe(gulp.dest(destFolder)));


    return merge2(streams);
});



const transforms = [
  {
    src: "./wwwroot/media-test/*",
    dist: "./wwwroot/media-test/dist/",
    params: {
      width: 768
    }
  }
];

gulp.task("img:copy", () => {
  return gulp.src("./wwwroot/media-test/**/*", { nodir: true })
    .pipe(gulpNewer("./wwwroot/media-test/dist/"))
    .pipe(gulpImagemin({
      progressive: true,
      svgoPlugins: [{ removeViewBox: false }, { removeUselessStrokeAndFill: false }]
    }))
    .pipe(gulp.dest("./wwwroot/media-test/dist/"));
});

gulp.task("img:clean", ["img:clean:directories"], () => {

  // get arrays of src and dist filepaths (returns array of arrays)
  return Promise.all([

    globby("./wwwroot/media-test/**/*", { nodir: true }),
    globby("./wwwroot/media-test/dist/", { nodir: true })

  ])
  .then((paths) => {

    // create arrays of filepaths from array of arrays returned by promise
    const srcFilepaths = paths[0];
    const distFilepaths = paths[1];

    // empty array of files to delete
    const distFilesToDelete = [];

    // diffing
    distFilepaths.map((distFilepath) => {

      // sdistFilepathFiltered: remove dist root folder and thumbs folders names for comparison
      const distFilepathFiltered = distFilepath.replace(/\/public/, "").replace(/thumbs_[0-9]+x[0-9]+\//, "");

      // check if simplified dist filepath is in array of src simplified filepaths
      // if not, add the full path to the distFilesToDelete array
      if ( srcFilepaths.indexOf(distFilepathFiltered) === -1 ) {
        distFilesToDelete.push(distFilepath);
      }

    });

    // return array of files to delete
    return distFilesToDelete;

  })
  .then((distFilesToDelete) => {

    // delete files
    del.sync(distFilesToDelete);

  })
  .catch((error) => {

    console.log(error);

  });

});

gulp.task("img:clean:directories", () => {
  globby("./wwwroot/media-test/dist/**/thumbs_+([0-9])x+([0-9])/")
    .then((paths) => {

      console.log("All thumbs folders: " + paths);

      // existing thumbs directories in dist
      const distThumbsDirs = paths;

      // create array of dirs that should exist by walking transforms map
      const srcThumbsDirs = transforms.map((transform) => transform.dist + "thumbs_" + transform.params.width + "x" + transform.params.height + "/");

      // array of dirs to delete
      const todeleteThumbsDirs = distThumbsDirs.filter((el) => srcThumbsDirs.indexOf(el) === -1);

      console.log("To delete thumbs folders: " + todeleteThumbsDirs);

      // pass array to next step
      return todeleteThumbsDirs;

    })
    .then((todeleteThumbsDirs) => {

      // deleted diff thumbnails directories
      del.sync(todeleteThumbsDirs);

    })
    .then(() => {

      // delete empty directories in dist images
      deleteEmpty.sync("./wwwroot/media-test/");

    })
    .catch((error) => {

      console.log(error);

    });
});

gulp.task("img", ["img:copy", "img:thumbnails"]);

gulp.task("img:thumbnails", () => {
    const streams=[];

    transforms.map((transform) => {
        streams.push(
            gulp.src(transform.src)
                .pipe(gulpNewer(transform.dist+"thumbs_"+transform.params.width))
                .pipe(gulpImageresize({
                    imageMagick: true,
                    width: transform.params.width,
                    crop: false
                    }))
                .pipe(gulpImagemin({
                    progressive: true,
                    svgoPlugins:[{removeViewBox: false},{removeUselessStrokeAndFill: false}]
                    }))
            .pipe(gulp.dest(transform.dist+"thumbs_"+transform.params.width))
        );
    });

    return merge2(streams);
});