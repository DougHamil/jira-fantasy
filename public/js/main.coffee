require.config
  baseUrl: 'js'
  paths:
    jquery: 'lib/jquery'
    pixi: 'lib/pixi'
    jiraheroes: 'lib/jiraheroes'

require ['jquery', 'jiraheroes'], ($, JH) ->
  $(document).ready ->
    JH.GetHeroes (heroes) ->
      console.log heroes

    JH.GetUser (user) ->
      window.user = user
      console.log "#{user.name} has #{user.points} points"
      $("#message").text("You have earned #{user.points} points since your last login on #{user.lastLogin}")

