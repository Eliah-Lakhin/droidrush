var gulp = require('gulp');
var debug = require('gulp-debug');
var watch = require('gulp-watch');
var rename = require('gulp-rename');
var browserify = require('gulp-browserify');

var server = require('tiny-lr')();

gulp.task('default', ['compile', 'live']);

gulp.task('compile', ['jade', 'script']);

gulp.task('jade', function() {
  watch({glob: './src/**/*.jade'})
    .pipe(require('gulp-jade')({pretty: true}))
    .pipe(gulp.dest('./build'));
});

gulp.task('script', function() {
  gulp
    .src('node_modules/pixi.js/bin/pixi.js', {read: false})
    .pipe(browserify())
    .on('prebundle', function(bundle) {
      bundle.require('pixi.js', {expose: 'pixi'});
    })
    .pipe(rename('pixi.js'))
    .pipe(gulp.dest('./build/vendor'));

  watch({glob: './src/**/*.coffee'}, function() {
    gulp
      .src('./src/index.coffee', {read: false})
      .pipe(browserify({
        transform: ['coffeeify'],
        extensions: ['.coffee']
      }))
      .on('prebundle', function(bundle) {
        bundle.external('pixi');
      })
      .on('error', console.warn)
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
