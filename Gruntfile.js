// Generated on 2013-08-19 using generator-webapp 0.2.7
'use strict';
var LIVERELOAD_PORT = 35729;
var lrSnippet = require('connect-livereload')({port: LIVERELOAD_PORT});
var mountFolder = function (connect, dir) {
    return connect.static(require('path').resolve(dir));
};

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {
    // load all grunt tasks
    require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

    // configurable paths
    var yeomanConfig = {
        app: 'app',
        dist: 'dist'
    };

    grunt.initConfig({
        yeoman: yeomanConfig,
        watch: {
            coffee: {
                files: ['<%= yeoman.app %>/scripts/**/*.coffee'],
                tasks: ['coffee:dist']
            },
            coffeeTest: {
                files: ['test/spec/**/*.coffee'],
                tasks: ['coffee:test']
            },
            // compass: {
            //     files: ['<%= yeoman.app %>/styles/**/*.{scss,sass}'],
            //     tasks: ['compass:server']
            // },
            livereload: {
                options: {
                    livereload: LIVERELOAD_PORT,
                    spawn: false
                },
                files: [
                    '<%= yeoman.app %>/*.html',
                    '{.tmp,<%= yeoman.app %>}/styles/**/*.css',
                    '{.tmp,<%= yeoman.app %>}/scripts/**/*.js',
                    '<%= yeoman.app %>/images/**/*.{png,jpg,jpeg,gif,webp,svg}'
                ]
            }
        },
        connect: {
            server : {
                options: {
                    port: 9000,
                    hostname: '0.0.0.0'
                }
            },
            livereload: {
                options: {
                    port: 9000,
                    hostname: '0.0.0.0',
                    directory: '.',
                    middleware: function (connect) {
                        return [
                            lrSnippet,
                            mountFolder(connect, '.tmp'),
                            mountFolder(connect, yeomanConfig.app),
                            mountFolder(connect, '.') // workarround to server .map and .coffee
                        ];
                    },
                    open: true
                }
            },
            dist: {
                options: {
                    port: 9000,
                    hostname: '0.0.0.0',
                    middleware: function (connect) {
                        return [
                            mountFolder(connect, yeomanConfig.dist)
                        ];
                    },
                    open: true
                }
            }
        },
        clean: {
            dist: {
                files: [{
                    dot: true,
                    src: [
                        '.tmp',
                        '<%= yeoman.dist %>/*',
                        '!<%= yeoman.dist %>/.git*'
                    ]
                }]
            },
            server: '.tmp'
        },
        jshint: {
            options: {
                jshintrc: '.jshintrc'
            },
            all: [
                // 'Gruntfile.js',
                '<%= yeoman.app %>/scripts/**/*.js',
                '!<%= yeoman.app %>/scripts/vendor/*',
                'test/spec/**/*.js'
            ]
        },
        karma: {
            dev: {
                configFile: 'karma.conf.js',
                browsers: ['PhantomJS'],
                autoWatch: true
            },
            build: {
                configFile: 'karma.conf.js',
                singleRun: true
            },
            travis: {
                configFile: 'karma.conf.js',
                browsers: ['PhantomJS', 'Firefox'],
                singleRun: true
            }
        },
        coveralls: {
            options: {
                debug: true,
                coverage_dir: 'coverage'
            }
        },
        coffee: {
            dist: {
                options: {
                    sourceMap: true
                },
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>/scripts',
                    src: '**/*.coffee',
                    dest: '.tmp/scripts',
                    rename: function(dest, src) {
                        return dest + '/' + src.substring(0, src.lastIndexOf('.')) + '.js';
                    }
                }]
            },
            test: {
                options: {
                    sourceMap: true
                },
                files: [{
                    expand: true,
                    cwd: 'test/spec',
                    src: '**/*.coffee',
                    dest: '.tmp/spec',
                    rename: function(dest, src) {
                        return dest + '/' + src.substring(0, src.lastIndexOf('.')) + '.js';
                    }
                }]
            }
        },
        // compass: {
        //     options: {
        //         sassDir: '<%= yeoman.app %>/styles',
        //         cssDir: '.tmp/styles',
        //         generatedImagesDir: '.tmp/images/generated',
        //         imagesDir: '<%= yeoman.app %>/images',
        //         javascriptsDir: '<%= yeoman.app %>/scripts',
        //         fontsDir: '<%= yeoman.app %>/styles/fonts',
        //         importPath: '<%= yeoman.app %>/bower_components',
        //         httpImagesPath: '/images',
        //         httpGeneratedImagesPath: '/images/generated',
        //         httpFontsPath: '/styles/fonts',
        //         relativeAssets: false
        //     },
        //     dist: {
        //         options: {
        //             generatedImagesDir: '<%= yeoman.dist %>/images/generated'
        //         }
        //     },
        //     server: {
        //         options: {
        //             debugInfo: true
        //         }
        //     }
        // },
        rev: {
            dist: {
                files: {
                    src: [
                        '<%= yeoman.dist %>/scripts/**/*.js',
                        '<%= yeoman.dist %>/styles/**/*.css'
                        // '<%= yeoman.dist %>/images/**/*.{png,jpg,jpeg,gif,webp}',
                        // '<%= yeoman.dist %>/styles/fonts/*'
                    ]
                }
            }
        },
        useminPrepare: {
            options: {
                dest: '<%= yeoman.dist %>'
            },
            html: '<%= yeoman.app %>/index.html'
        },
        usemin: {
            options: {
                dirs: ['<%= yeoman.dist %>']
            },
            html: ['<%= yeoman.dist %>/**/*.html'],
            css: ['<%= yeoman.dist %>/styles/**/*.css']
        },
        imagemin: {
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>/images',
                    src: '**/*.{png,jpg,jpeg}',
                    dest: '<%= yeoman.dist %>/images'
                }]
            }
        },
        svgmin: {
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>/images',
                    src: '**/*.svg',
                    dest: '<%= yeoman.dist %>/images'
                }]
            }
        },
        htmlmin: {
            dist: {
                options: {
                    /*removeCommentsFromCDATA: true,
                    // https://github.com/yeoman/grunt-usemin/issues/44
                    //collapseWhitespace: true,
                    collapseBooleanAttributes: true,
                    removeAttributeQuotes: true,
                    removeRedundantAttributes: true,
                    useShortDoctype: true,
                    removeEmptyAttributes: true,
                    removeOptionalTags: true*/
                },
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>',
                    src: '{./,sections/}*.html',
                    dest: '<%= yeoman.dist %>'
                }]
            }
        },
        // Put files not handled in other tasks here
        copy: {
            dist: {
                files: [{
                    expand: true,
                    dot: true,
                    cwd: '<%= yeoman.app %>',
                    dest: '<%= yeoman.dist %>',
                    src: [
                        '*.{ico,png,txt}',
                        '.htaccess',
                        'images/**/*.{webp,gif}',
                        'styles/fonts/*',
                        'templates/*.mustache',
                        'l10n/*.{ini,properties}',
                        'manifest.webapp'
                    ]
                }]
            }
        },
        concurrent: {
            server: [
                // 'compass:server',
                'coffee:dist'
            ],
            test: [
                'coffee'
            ],
            dist: [
                'coffee',
                // 'compass',
                'imagemin',
                'svgmin',
                'htmlmin'
            ]
        },
        compress: {
            firefox: {
                options: {
                  archive: 'app.zip',
                  mode: 'zip'
                },
                files: [
                    {cwd: 'dist/', expand: true, src: '**/*'}
                ]
            }
        },
        bower: {
            install: {

            }
        }
    });

    grunt.registerTask('server', function (target) {
        if (target === 'dist') {
            return grunt.task.run(['build', 'connect:dist:keepalive']);
        } else if (target === 'test') {
            return grunt.task.run([
                'clean:server',
                'concurrent:test',
                'connect:test',
                'watch']);
        }

        grunt.task.run([
            'clean:server',
            'concurrent:server',
            'connect:livereload',
            'watch'
        ]);
    });

    grunt.registerTask('test', function (target) {
        target = target || 'build';
        grunt.task.run([
            'clean:server',
            'concurrent:test',
            'karma:' + target
        ]);
    });

    grunt.registerTask('build', [
        'clean:dist',
        'useminPrepare',
        'concurrent:dist',
        'concat',
        'cssmin',
        'uglify',
        'copy:dist',
        'rev',
        'usemin',
        'compress:firefox'
    ]);

    grunt.registerTask('default', [
        'jshint',
        'test',
        'build'
    ]);

    grunt.registerTask('travis', [
        'bower',
        'jshint',
        'test:travis',
        'coveralls'
    ]);
};
