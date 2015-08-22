module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    sass: {
      options: {
        includePaths: ['bower_components/foundation/scss']
      },
      dist: {
        options: {
          outputStyle: 'expanded',
          sourceMap: true,
        },
        files: {
          '../css/app.css': 'scss/app.scss'
        }
      }
    },
    bower_concat: {
      all: {
        dest: '../public/js/lib/lib.js',
        //cssDest: '../public/css/lib/foundation.css',
        //exclude: [
        //  'jquery',
        //  'modernizr'
        //],
        dependencies: {
          'underscore': 'jquery',
          'backbone': 'underscore',
          'jquery-mousewheel': 'jquery'
        },
        bowerOptions: {
          relative: false
        }
      }
    },
    uglify: {
      my_target: {
        //options: {
        //  sourceMap: true,
        //  sourceMapName: 'path/to/sourcemap.map'
        //},
        files: {
          'public/js/lib/lib.min.js': ['build/lib/lib.js'],
          //'public/css/lib/foundation.min.css': ['build/lib/foundation.css'],
        }
      }
    },
    watch: {
      grunt: {
        options: {
          reload: true
        },
        files: ['Gruntfile.js']
      },

      sass: {
        files: 'scss/**/*.scss',
        tasks: ['sass']
      }
    }
  });

  grunt.loadNpmTasks('grunt-sass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-bower-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');

  grunt.registerTask('build', ['sass', 'bower_concat']);
  grunt.registerTask('default', ['build','watch']);
  grunt.registerTask('watch', ['watch']);
}
