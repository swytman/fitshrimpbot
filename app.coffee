TGbot = require('node-telegram-bot-api')
Program = require('./app/program')
urlencode = require('urlencode')
Subscription = require('./app/subscription')
require('./app/helpers')
schedule = require('node-schedule');

token = config.app.token
bot = new TGbot(token, {polling: true})

console.log(token)



j = schedule.scheduleJob('notify_day', '0 8 * * *', ->
  subscription = new Subscription
  subscription.schedule().then((body)->
    if body.subscriptions.length > 0
      for v in body.subscriptions
        console.log(v.message)
        bot.sendMessage v.id, message_from_server(v), {parse_mode: 'Markdown'}


  ).catch (err) ->
    console.log err
)




message_from_server = (body) ->
  decoded = body.message.replace(/<br>/g, '\n')
  console.log(decoded)
  decoded


bot_standart_response = (bot, id, text ) ->
  bot.sendMessage id, text, {parse_mode: 'Markdown'}, {parse_mode: 'Markdown'}

bot.on 'message', (msg) ->
  console.log(msg)

#  /programs
  if msg.text == '/programs'
    programs = new Program
    programs.search().then((body)->
      bot.sendMessage msg.from.id, message_from_server(body), {parse_mode: 'Markdown'}
    ).catch (err) ->
      bot.sendMessage msg.from.id, 'Ошибочка вышла' + err


#   /sign
  if msg.text.startsWith '/sign'
    id = msg.text.split(" ")[1]
    subscription = new Subscription
    subscription.sign(id, msg.from.id).then((body)->
      bot.sendMessage msg.from.id, message_from_server(body), {parse_mode: 'Markdown'}
    ).catch (err) ->
      bot.sendMessage msg.from.id, 'Ошибочка вышла' + err

#   /unsign
  if msg.text.startsWith '/unsign'
    id = msg.text.split(" ")[1]
    subscription = new Subscription
    subscription.unsign(id, msg.from.id).then((body)->
      bot.sendMessage msg.from.id, message_from_server(body), {parse_mode: 'Markdown'}
    ).catch (err) ->
      bot.sendMessage msg.from.id, 'Ошибочка вышла' + err

  #   /mysigns
  if msg.text.startsWith '/mysigns'
    subscription = new Subscription
    subscription.signs(msg.from.id).then((body)->
      bot.sendMessage msg.from.id, message_from_server(body), {parse_mode: 'Markdown'}
    ).catch (err) ->
      bot.sendMessage msg.from.id, 'Ошибочка вышла' + err

  #   /mysigns
  if msg.text.startsWith '/today'
    subscription = new Subscription
    subscription.today(msg.from.id).then((body)->
      bot.sendMessage msg.from.id, message_from_server(body), {parse_mode: 'Markdown'}
    ).catch (err) ->
      bot.sendMessage msg.from.id, 'Ошибочка вышла' + err
