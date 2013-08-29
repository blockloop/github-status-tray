(function(){
    var scriptFiles = [
        'src/coffee/**/*.coffee'
    ];

    module.exports = function(grunt) {
        grunt.initConfig({
            jshint: {
                options: {
                    jshintrc: '/home/brett/Dropbox/configs/dotfilex/.jshintrc'
                },
                all: scriptFiles
            },
            jade: {
                compile: {
                    options: {
                        pretty: true,
                        data: {
                            debug: false
                        }
                    },
                    files: [{
                        expand: true,
                        cwd: "src/jade/",
                        src: "*.jade",
                        dest: "app/views/",
                        ext: ".html"
                    }]
                }

            },
            stylus: {
                compile: {
                    options:{
                        compress: true,
                    },
                    files: [{
                        expand: true,
                        cwd: 'src/styl/',
                        src: ['*.styl'],
                        dest: 'app/styles',
                        ext: '.css',
                    }]
                }
            },
            coffee: {
                compile: {
                    options:{
                        join: false,
                        sourceMap: false
                    },
                    files: {
                        'app/scripts/node-main.js': 'src/coffee/node-main.coffee',
                        'app/scripts/main.js': 'src/coffee/main.coffee',
                        'app/scripts/site.js': [
                            'src/coffee/**/*.coffee',
                            '!src/coffee/node-main.coffee',
                            '!src/coffee/main.coffee'
                        ]
                    }
                }
            },
            watch: {
                stylus: {
                    files: 'src/styl/*.styl',
                    tasks: ['stylus']
                },
                scripts: {
                    files : scriptFiles,
                    tasks: ['coffee:compile','test'],
                    options: {
                        interrupt: true,
                    },
                },
                test: {
                    files: [
                        'test/**/*.js'
                    ],
                    tasks: ['test']
                },
                jade: {
                    files: 'src/jade/**/*.jade',
                    tasks: ['jade'],
                }
            },
            exec: {
                test: {
                    // command: 'node test/mocha-runner.js',
                    command: 'echo "tests not implemented"',
                    stdout: true
                }
            },
            notify_hooks: {
                options: {
                    enabled: true,
                    max_jshint_notifications: 3, // maximum number of notifications from jshint output
                    title: "github-status-tray"
                }
            }
        });

        // Default task
        grunt.registerTask('default','dev');
        grunt.registerTask('dev', ['compile','watch']);
        grunt.registerTask('test', ['exec:test']);
        grunt.registerTask('compile', ['coffee','stylus','jade:compile'])
        grunt.registerTask('bootstrap', ['jshint','compile'])
        grunt.loadNpmTasks('grunt-contrib-stylus');
        grunt.loadNpmTasks('grunt-contrib-watch');
        grunt.loadNpmTasks('grunt-contrib-jshint');
        grunt.loadNpmTasks('grunt-contrib-jade');
        grunt.loadNpmTasks('grunt-contrib-coffee');
        grunt.loadNpmTasks('grunt-notify');
        grunt.loadNpmTasks('grunt-exec');

        // This is required if you use any options.
        grunt.task.run('notify_hooks');
    }; // module.exports

})();
