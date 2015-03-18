/**
 * Created by alonch on 16/03/15.
 */
module.exports = function(config) {
    config.set({
        // base path used to resolve all patterns (e.g. files, exclude)
        basePath: '',
        // frameworks to use
        frameworks: ['jasmine'],
        // list of files / patterns to load in the browser
        files: [
            'node_modules/angular/angular.js',
            'node_modules/angular-mocks/angular-mocks.js',
            'src/public/js/*.js',
            'src/public-test/js/*.spec.js'
        ],

        // list of files to exclude
        exclude: [
            "src/public/js/angular.js",
            "src/public/js/bootstrap.min.js",
            "src/public/js/jquery.js",
            "src/public/js/socket.io.js"
        ],

        // preprocess matching files before serving them to the browser
        preprocessors: {
            'src/public/js/*.js': ['coverage']
        },

        coverageReporter: {
            type: 'text-summary',
            dir: 'coverage-public/'
        },

        // test results reporter to use
        reporters: ['progress', 'coverage'],

        // web server port
        port: 9876,

        // enable / disable colors in the output (reporters and logs)
        colors: true,

        // level of logging
        logLevel: config.LOG_INFO,

        // enable / disable watching file and executing tests on file changes
        autoWatch: true,

        // start these browsers
        browsers: ['Chrome'],

        // Continuous Integration mode
        // if true, Karma captures browsers, runs the tests and exits
        singleRun: false
    });
};