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

  unsign: (program_id, telegram_id) ->
    options = {
      uri: @url+'unsign' ,
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

  signs: (telegram_id) ->
    options = {
      uri: @url+'signs' ,
      body: {telegram_id: telegram_id}
      headers: {
        'User-Agent': 'Request-Promise'
      },
      json: true
    }

    rp(options).then((body) ->
      return body
    ).catch (err) ->
      return err

  today: (telegram_id) ->
    options = {
      uri: @url+'today' ,
      body: {telegram_id: telegram_id}
      headers: {
        'User-Agent': 'Request-Promise'
      },
      json: true
    }

    rp(options).then((body) ->
      return body
    ).catch (err) ->
      return err

  schedule: ->
    options = {
      uri: @url+'schedule' ,
      headers: {
        'User-Agent': 'Request-Promise'
      },
      json: true
    }

    rp(options).then((body) ->
      return body
    ).catch (err) ->
      return err




