
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

gulp.task("img:copy", ()=> {
    gulp.src([srcFolder + "*.jpg",srcFolder + "*.png"], {nodir: true})
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