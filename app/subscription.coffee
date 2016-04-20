rp = require('request-promise')
global.config = require('konfig')()
module.exports = class Program


  constructor: ->
    @url = config.app.backend.host
    @options = options = {
      headers: {
        'User-Agent': 'Request-Promise'
      },
      json: true
    }

  sign: (program_id, telegram_id) ->
    options = @options
    options.uri = @url+'sign'
    options.body = {program_id: program_id, telegram_id: telegram_id}

    rp(options).then((body) ->
      return body
    ).catch (err) ->
      return err

  unsign: (program_id, telegram_id) ->
    options = @options
    options.uri = @url+'unsign'
    options.body = {program_id: program_id, telegram_id: telegram_id}

    rp(options).then((body) ->
      return body
    ).catch (err) ->
      return err

  mysigns: (telegram_id) ->
    options = @options
    options.uri = @url+'mysigns'
    options.body = {telegram_id: telegram_id}

    rp(options).then((body) ->
      return body
    ).catch (err) ->
      return err

  today: (telegram_id) ->

    options = @options
    options.uri = @url+'today'
    options.body = {telegram_id: telegram_id}

    rp(options).then((body) ->
      return body
    ).catch (err) ->
      return err

  schedule: ->
    options = @options
    options.uri = @url+'schedule'

    rp(options).then((body) ->
      return body
    ).catch (err) ->
      return err

  day: (order, telegram_id) ->

    options = @options
    options.uri = @url+'day'
    options.body = {order: order, telegram_id: telegram_id}

    rp(options).then((body) ->
      return body
    ).catch (err) ->
      return err




