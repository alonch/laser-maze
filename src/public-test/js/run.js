// Generated by CoffeeScript 1.9.1
(function() {
  var currentWindowOnload, htmlReporter, jasmineEnv;

  jasmineEnv = jasmine.getEnv();

  jasmineEnv.updateInterval = 1000;

  htmlReporter = new jasmine.HtmlReporter();

  jasmineEnv.addReporter(htmlReporter);

  jasmineEnv.specFilter = function(spec) {
    return htmlReporter.specFilter(spec);
  };

  currentWindowOnload = window.onload;

  window.onload = function() {
    if (currentWindowOnload) {
      currentWindowOnload();
    }
    return execJasmine();
  };

  execJasmine(function() {
    return jasmineEnv.execute();
  });

}).call(this);
