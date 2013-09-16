(function() {

  require.config({
    baseUrl: 'js',
    paths: {
      jquery: 'lib/jquery',
      pixi: 'lib/pixi',
      jiraheroes: 'lib/jiraheroes'
    }
  });

  require(['jquery', 'jiraheroes'], function($, JH) {
    return $(document).ready(function() {
      JH.GetHeroes(function(heroes) {
        return console.log(heroes);
      });
      return JH.GetUser(function(user) {
        window.user = user;
        return console.log("" + user.name + " has " + user.points + " points");
      });
    });
  });

}).call(this);
