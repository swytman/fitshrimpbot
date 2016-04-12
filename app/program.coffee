rp = require('request-promise')
global.config = require('konfig')()
module.exports = class Program

  constructor: ->
    @url = config.app.backend.host + config.app.backend.programs

  search: ->
    options = {
      uri: @url ,
      headers: {
        'User-Agent': 'Request-Promise'
      },
      json: true
    }

    rp(options).then((body) ->
      return body
    ).catch (err) ->
      console.log(err)
      return err

