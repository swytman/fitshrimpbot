TGbot = require('node-telegram-bot-api')
Program = require('./app/program')

token = config.app.token
bot = new TGbot(token, {polling: true})
console.log(token)



bot.on 'message', (msg) ->
  console.log(msg)

  if (msg.text == '/programs' || msg.text == 'programs')
    programs = new Program
    list = []
    list = programs.search().then((body)->
      if body.programs.length > 0
        str = ''
        str+= "Вам доступны следующие программы:\n------------------\n"
        for _,v of body.programs
          console.log(body.programs)
          str+="ID:#{v.id} - #{v.title}\n#{v.description}\n"
          str+="Всего дней - #{v.program_days.length}\n"
          str+="------------------\n"
        bot.sendMessage(msg.from.id, str)
      else
        bot.sendMessage(msg.from.id, "Нет доступных программ")
    ).catch (err) ->
      bot.sendMessage(msg.from.id, 'Ошибочка вышла(' + err)

