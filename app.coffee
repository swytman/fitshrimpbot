TGbot = require('node-telegram-bot-api')
Program = require('./app/program')

token = config.app.token
bot = new TGbot(token, {polling: true})
console.log(token)


bot.on 'message', (msg) ->
  console.log(msg)

  if (msg.text == '/programs' || msg.text == 'programs')
    programs = new Program
    console.log(programs)
    bot.sendMessage(msg.from.id, programs.search())

