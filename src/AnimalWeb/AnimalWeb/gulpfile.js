
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


const widths = [1920,1600,1366,1024,768,640];



gulp.task("img:optimize",()=> {
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

gulp.task("img:resize", () => {
    const streams=[];

    widths.map((width) => {
        streams.push(gulp.src([srcFolder + "*.jpg",srcFolder + "*.png"], {nodir: true})
                /*.pipe(gulpNewer(destFolder+"thumbs_"+'768px'))*/
                .pipe(gulpImageresize({
                    imageMagick: true,
                    width: width,
                    crop: false
                    }))
                .pipe(gulpImagemin({
                    progressive: true,
                    svgoPlugins:[{removeViewBox: false},{removeUselessStrokeAndFill: false}]
                    }))
            .pipe(rename(function(path){
                path.basename += "-"+width+"px"
            }))
            .pipe(gulp.dest(destFolder)))
    });
    
    return merge2(streams);
}); 

gulp.task("img:update",["img:resize","img:copy","img:optimize"], () => {
    // TODO
});