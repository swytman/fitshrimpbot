request = require('request')
global.config = require('konfig')()
module.exports = class Program

  constructor: () ->
    @url = config.app.request.programs
  search: ->
    request @url, (error, response, body) ->
      console.log(@url)
      return 'Ошибка' if error
      return body