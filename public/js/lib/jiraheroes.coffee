define ['jquery'], ($) ->
  class JiraHeroes
    @GetUser: (cb) ->
      $.ajax
        url: '/user/info'
      .done (data) ->
        cb data
  return JiraHeroes





