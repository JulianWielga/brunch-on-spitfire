var git, gitRev;

exports.config = {
  conventions: {
    assets: /^app[\/\\]assets/,
    ignored: /^(bower_components[\/\\]bootstrap-less(-themes)?|app[\/\\]styles[\/\\]overrides|(.*?[\/\\])?[_]\w*)/
  },
  modules: {
    definition: false,
    wrapper: false
  },
  paths: {
    "public": '_public',
    watched: ['app', 'vendor']
  },
  files: {
    javascripts: {
      joinTo: {
        'js/app.js': /^app/,
        'js/vendor.js': /^(bower_components|vendor)/
      },
      order: {
        before: ['bower_components/jquery/dist/jquery.js']
      }
    },
    stylesheets: {
      joinTo: {
        'css/vendor.css': /^(vendor|bower_components)/,
        'css/app.css': /^(app)/
      },
      order: {
        before: ['app/styles/bootstrap/bootstrap.less'],
        after: []
      }
    },
    templates: {
      joinTo: {
        'js/templates.js': /^app.*[\/\\]templates[\/\\].*jade$/
      }
    }
  },
  plugins: {
    jadeNgtemplates: {
      modules: [
        {
          name: "templates",
          pattern: /^app[\/\\]templates[\/\\].*jade$/,
          url: function(path) {
            var name;
            name = path.replace(/^app[\/\\].*templates[\/\\](.*).jade$/, '$1').replace(/[\/\\]/g, '.');
            return "/templates/" + name + ".html";
          }
        }, {
          name: "templates.modules",
          pattern: /^app[\/\\].*[\/\\]templates[\/\\].*jade$/,
          url: function(path) {
            var dir, name;
            dir = path.replace(/^app[\/\\]modules[\/\\](.*)templates[\/\\].*/, '$1');
            name = path.replace(/^app[\/\\]modules[\/\\].*templates[\/\\](.*).jade$/, '$1').replace(/[\/\\]/g, '.');
            return "/templates/" + dir + name + ".html";
          }
        }
      ],
      jade: {
        pretty: true,
        doctype: "xml",
        basedir: 'app'
      },
      htmlmin: false
    },
    jadePages: {
      pattern: /^app[\/\\]index.jade$/,
      jade: {
        pretty: true,
        doctype: "xml",
        basedir: 'app'
      },
      htmlmin: false
    },
    assetsmanager: {
      copyTo: {
        fonts: ['bower_components/bootstrap/dist/fonts/*']
      }
    }
  },
  overrides: {
    production: {
      optimize: false,
      sourceMaps: true
    }
  },
  server: {
    port: 3335,
    base: ''
  }
};

if (typeof process !== "undefined" && process !== null) {
  process.server = exports.config.server;
}

if (typeof process !== "undefined" && process !== null) {
  process.git = git = {};
}

gitRev = require('git-rev');

gitRev.long(function(hash) {
  return git.hash = hash;
});

gitRev.branch(function(name) {
  return git.branch = name;
});

gitRev.tag(function(name) {
  return git.tag = name;
});
