TGbot = require('node-telegram-bot-api')
Program = require('./app/program')
urlencode = require('urlencode')
Subscription = require('./app/subscription')
require('./app/helpers')

schedule = require('node-schedule');

token = config.app.token
bot = new TGbot(token, {polling: true})
bot_commands = require('./app/dicts/commands')


console.log(token)



j = schedule.scheduleJob('notify_day', '0 8 * * *', ->
  subscription = new Subscription
  subscription.schedule().then((body)->
    console.log(body)
    if body.message.length > 0
      for v in body.message
        bot.sendMessage v.id, message_from_server(v), {parse_mode: 'Markdown'}
  ).catch (err) ->
    console.log err
)


message_from_server = (body) ->
  decoded = body.message.replace(/<br>/g, '\n')
  console.log(decoded)
  decoded


bot.on 'message', (msg) ->
  console.log(msg)

#  /programs
  if msg.text.startsWith  '/programs'
    programs = new Program
    programs.programs().then((body)->
      bot.sendMessage msg.chat.id, message_from_server(body), {parse_mode: 'Markdown'}
    ).catch (err) ->
      bot.sendMessage msg.chat.id, 'Ошибочка вышла' + err

#  /details ID
  if msg.text.startsWith '/details'
    programs = new Program
    id = msg.text.split(" ")[1]
    programs.details(id).then((body)->
      bot.sendMessage msg.chat.id, message_from_server(body), {parse_mode: 'Markdown'}
    ).catch (err) ->
      bot.sendMessage msg.chat.id, 'Ошибочка вышла' + err

#   /sign ID
  if msg.text.startsWith '/sign'
    id = msg.text.split(" ")[1]
    subscription = new Subscription
    subscription.sign(id, msg.from.id).then((body)->
      bot.sendMessage msg.chat.id, message_from_server(body), {parse_mode: 'Markdown'}
    ).catch (err) ->
      bot.sendMessage msg.chat.id, 'Ошибочка вышла' + err

#   /unsign ID
  if msg.text.startsWith '/unsign'
    id = msg.text.split(" ")[1]
    subscription = new Subscription
    subscription.unsign(id, msg.from.id).then((body)->
      bot.sendMessage msg.chat.id, message_from_server(body), {parse_mode: 'Markdown'}
    ).catch (err) ->
      bot.sendMessage msg.chat.id, 'Ошибочка вышла' + err

  #   /mysigns
  if msg.text.startsWith '/mysigns'
    subscription = new Subscription
    subscription.mysigns(msg.from.id).then((body)->
      bot.sendMessage msg.chat.id, message_from_server(body), {parse_mode: 'Markdown'}
    ).catch (err) ->
      bot.sendMessage msg.chat.id, 'Ошибочка вышла' + err

  #   /today
  if msg.text.startsWith '/today'
    subscription = new Subscription
    subscription.today(msg.from.id).then((body)->
      bot.sendMessage msg.chat.id, message_from_server(body), {parse_mode: 'Markdown'}
    ).catch (err) ->
      bot.sendMessage msg.chat.id, 'Ошибочка вышла' + err

  #   /day ID
  if msg.text.startsWith '/day'
    id = msg.text.split(" ")[1]
    subscription = new Subscription
    subscription.day(id, msg.from.id).then((body)->
      bot.sendMessage msg.chat.id, message_from_server(body), {parse_mode: 'Markdown'}
    ).catch (err) ->
      bot.sendMessage msg.chat.id, 'Ошибочка вышла' + err


  if msg.text.startsWith '/help'
    str = 'Список доступных комманд: \n'
    for k, v of bot_commands
      str+="*#{k}* - #{v}\n"
    bot.sendMessage msg.chat.id, str, {parse_mode: 'Markdown'}
