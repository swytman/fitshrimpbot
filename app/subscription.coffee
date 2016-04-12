rp = require('request-promise')
global.config = require('konfig')()
module.exports = class Program


  constructor: ->
    @url = config.app.backend.host + config.app.backend.subscriptions

  sign: (program_id, telegram_id) ->
    options = {
      uri: @url+'sign' ,
      body: {program_id: program_id, telegram_id: telegram_id}
      headers: {
        'User-Agent': 'Request-Promise'
      },
      json: true
    }

    rp(options).then((body) ->
      return body
    ).catch (err) ->
      return err
