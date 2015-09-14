exports.config = {
  suites: {
    app: 'e2e/app/**/*.coffee'
  },
  capabilities: {
    browserName: 'chrome',
    acceptSslCerts: true
  },
  baseUrl: 'http://localhost:3334/cms/',
  rootElement: 'html',
  framework: 'jasmine',
  jasmineNodeOpts: {
    defaultTimeoutInterval: 30000
  }
};