// Gulp.js configuration
var gulp = require('gulp'),
    lost = require('lost'),
    cssnano = require('cssnano'),
    autoprefixer = require('autoprefixer')({}),
    watch = require('gulp-watch'),
    notify = require('gulp-notify'),
    simplevars = require('postcss-simple-vars'),
    postcss = require('gulp-postcss');

// apply PostCSS plugins
gulp.task('css', function() {
    var processors = [
      autoprefixer,
      cssnano,
      lost,
      simplevars
    ]
  return gulp.src('src/style.min.css')
    .pipe(postcss(processors))
    .pipe(gulp.dest('../public/css'))
    .pipe(notify({ message: 'Post CSS processing task complete' }));
});

gulp.task('default', ['css', 'watch']);

gulp.task('watch', function() {
    gulp.watch('src/*.css', ['css'])
});
