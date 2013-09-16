require.config
  baseUrl: 'js'
  paths:
    jquery: 'lib/jquery'
    pixi: 'lib/pixi'
    jiraheroes: 'lib/jiraheroes'

require ['jquery', 'jiraheroes'], ($, JH) ->
  $(document).ready ->
    console.log "Document is ready, requesting user."
    JH.GetUser (user) ->
      console.log "Received user info: "+user
      console.log "#{user.name} has #{user.points} points"

