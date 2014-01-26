var gulp = require('gulp');
var debug = require('gulp-debug');
var watch = require('gulp-watch');
var rename = require('gulp-rename');

var server = require('tiny-lr')();

gulp.task('default', ['compile', 'live']);

gulp.task('compile', ['jade', 'coffee']);

gulp.task('jade', function() {
  watch({glob: './src/**/*.jade'})
    .pipe(require('gulp-jade')({pretty: true}))
    .pipe(gulp.dest('./build'));
});

gulp.task('coffee', function() {
  watch({glob: './src/**/*.coffee'}, function() {
    gulp
      .src('./src/index.coffee', {read: false})
      .pipe(require('gulp-browserify')({
        transform: ['coffeeify'],
        extensions: ['.coffee']
      }))
      .pipe(rename('index.js'))
      .pipe(gulp.dest('./build'));
  });
});

gulp.task('live', ['server'], function() {
  server.listen(35729, function(err) {
    if (err) throw err;

    watch({glob: './build/**/*'})
      .pipe(require('gulp-livereload')(server))
  });
});

gulp.task('server', ['compile'], require('gulp-serve')({
  root: './build',
  middleware: require('connect-livereload')()
}));
