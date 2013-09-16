(function() {

  define(['jquery'], function($) {
    var JiraHeroes;
    JiraHeroes = (function() {

      function JiraHeroes() {}

      JiraHeroes.GetUser = function(cb) {
        return $.ajax({
          url: '/user/info'
        }).done(function(data) {
          return cb(data);
        });
      };

      return JiraHeroes;

    })();
    return JiraHeroes;
  });

}).call(this);
