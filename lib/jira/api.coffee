http = require 'http'

exports.getUser = (session, cb) ->
  http.request
    host: 'jira'
    path: '/rest/api/2/user?username='+session.username
    headers:
      'Authorization': "Basic " + new Buffer(session.username + ":" + session.password).toString('base64')
    , (res) ->
      data = ''
      res.on 'data', (chunk) ->
        data += chunk
      res.on 'end', () ->
        cb data
  .end()
