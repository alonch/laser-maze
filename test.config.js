/**
 * Created by alonch on 13/03/15.
 */
module.exports = function(config) {
    config.set({
        basePath: '',
        files: [
            'src/*.js',
            'test/*.js'
        ],
        //browsers: ['Chrome'],
        singleRun: true,
        reporters: ['progress', 'coverage'],
        preprocessors: { '*.js': ['coverage'] }
    });
};