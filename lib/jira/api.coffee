http = require 'http'

exports.getUser = (session, cb) ->
  http.request
    host: 'jira'
    port:8080
    path: '/rest/api/2/user?username='+session.username
    headers:
      'Authorization': "Basic " + new Buffer(session.username + ":" + session.password).toString('base64')
    , (res) ->
      data = ''
      res.on 'data', (chunk) ->
        data += chunk
      res.on 'end', () ->
        cb JSON.parse(data)
  .end()
