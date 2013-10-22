(function(){
    module.exports = function(grunt) {
        grunt.initConfig({
            watch: {
                stylus: {
                    files: 'src/**/*',
                    tasks: ['exec:harp']
                },
            },
            exec: {
                test: {
                    command: 'echo "tests not implemented"',
                    stdout: false,
                    stderr: true
                },
                harp: {
                    command: 'rm -rf app && harp compile src app',
                    stdout: true,
                    stderr: true
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
        grunt.registerTask('default','compile');
        grunt.registerTask('test', ['exec:test']);
        grunt.registerTask('compile', ['exec:harp'])
        grunt.loadNpmTasks('grunt-contrib-watch');
        grunt.loadNpmTasks('grunt-notify');
        grunt.loadNpmTasks('grunt-exec');

        // This is required if you use any options.
        grunt.task.run('notify_hooks');
    }; // module.exports

})();
