module.exports = function(config) {
  return config.set({
    basePath: "../",
    frameworks: ["jasmine"],
    files: ["_public/js/vendor.js", "_public/js/config.js", "_public/js/templates.js", "vendor/**/*.js", "vendor/**/*.coffee", "app/**/*.coffee", "bower_components/angular-mocks/angular-mocks.js", "test/unit/**/*.coffee"],
    exclude: [],
    reporters: ["progress", "junit", "coverage"],
    preprocessors: {
      "app/**/*.coffee": ["coffee", "coverage"],
      "vendor/**/*.coffee": ["coffee", "coverage"],
      "vendor/**/*.js": ["coverage"],
      "test/unit/**/*.coffee": ["coffee"]
    },
    coverageReporter: {
      reporters: [
        {
          type: "cobertura"
        }, {
          type: "text-summary"
        }
      ],
      instrumenter: {
        "**/*.coffee": "istanbul"
      }
    },
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ["PhantomJS"],
    singleRun: false
  });
};
