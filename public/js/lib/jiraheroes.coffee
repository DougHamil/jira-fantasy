define ['jquery'], ($) ->
  return {
    GetUser: (cb) ->
      $.ajax
        url: '/user/info'
      .done (data) ->
        cb data
    GetHeroes: (cb) ->
      $.ajax
        url: '/api/hero'
      .done (data) ->
        cb data
  }
