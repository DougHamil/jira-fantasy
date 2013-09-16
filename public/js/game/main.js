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
      console.log("Document is ready, requesting user.");
      return JH.GetUser(function(user) {
        console.log("Received user info: " + user);
        return console.log("" + user.name + " has " + user.points + " points");
      });
    });
  });

}).call(this);
