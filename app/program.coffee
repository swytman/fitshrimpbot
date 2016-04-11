rp = require('request-promise')
Q       = require("q")
global.config = require('konfig')()
module.exports = class Program

  constructor: ->
    @options = {
      uri: config.app.request.programs,
      headers: {
        'User-Agent': 'Request-Promise'
      },
      json: true
    }

  search: ->
    rp(@options).then((body) ->
      return body
    ).catch (err) ->
      console.log(err)
      return err
