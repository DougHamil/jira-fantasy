(function() {

  define(['jquery'], function($) {
    return {
      GetUser: function(cb) {
        return $.ajax({
          url: '/user/info'
        }).done(function(data) {
          return cb(data);
        });
      },
      GetHeroes: function(cb) {
        return $.ajax({
          url: '/api/hero'
        }).done(function(data) {
          return cb(data);
        });
      }
    };
  });

}).call(this);
