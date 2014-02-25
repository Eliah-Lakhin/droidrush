/*
    Droid Rush - browser based minimalistic realtime strategic videogame.
    Copyright (C) 2014 Ilya Lakhin (Илья Александрович Лахин) <eliah.lakhin@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
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
  var modules = ['pixi.js', 'events', 'raf', 'seed-random', 'extend',
    'keyboard-cjs'];

  var dependencies = {
    'raf': ['events']
  };

  modules.forEach(function(module) {
    var outputFile = module;

    if (outputFile.substr(outputFile.length - 3) !== '.js') outputFile += '.js';

    gulp
      .src('node_modules/' + module, {read: false})
      .pipe(browserify())
      .on('prebundle', function(bundle) {
        bundle.require(module);
        if (dependencies[module])
          dependencies[module]
            .forEach(function(module) {bundle.external(module);});
      })
      .pipe(rename(outputFile))
      .pipe(gulp.dest('./build/vendor'));
  });

  watch({glob: './src/**/*'}, function() {
    gulp
      .src('./src/index.coffee', {read: false})
      .pipe(browserify({
        transform: ['coffeeify'],
        extensions: ['.coffee']
      }))
      .on('prebundle', function(bundle) {
        modules.forEach(function(module) {bundle.external(module);});
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