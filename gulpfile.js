var gulp = require('gulp');
var watch = require('gulp-watch');

var server = require('tiny-lr')();

gulp.task('default', ['compile', 'live']);

gulp.task('compile', ['jade', 'coffee']);

gulp.task('jade', function() {
  gulp
    .src('./src/**/*.jade')
    .pipe(watch())
    .pipe(require('gulp-jade')({pretty: true}))
    .pipe(gulp.dest('./output/live'));
});

gulp.task('coffee', function() {
  gulp
    .src('./src/**/*.coffee')
    .pipe(watch())
    .pipe(require('gulp-coffee')())
    .pipe(gulp.dest('./output/live'));
});

gulp.task('live', ['server'], function() {
  server.listen(35729, function(err) {
    if (err) throw err;

    gulp
      .src('./output/live/**/*')
      .pipe(watch())
      .pipe(require('gulp-livereload')(server))
  });
});

gulp.task('server', ['compile'], require('gulp-serve')({
  root: './output/live',
  middleware: require('connect-livereload')()
}));

gulp.task('')