rp = require('request-promise')
global.config = require('konfig')()
module.exports = class Program

  constructor: ->
    @url = config.app.backend.host
    @options = {
      headers: {
        'User-Agent': 'Request-Promise'
      },
      json: true
    }

  programs: ->
    options = @options
    options.url = @url
    options.url = @url+'programs'

    rp(options).then((body) ->
      return body
    ).catch (err) ->
      console.log(err)
      return err

  details: (program_id) ->
    options = @options
    options.body = {program_id: program_id}
    options.url = @url+'details'
    console.log(options)
    rp(options).then((body) ->
      return body
    ).catch (err) ->
      console.log(err)
      return err


