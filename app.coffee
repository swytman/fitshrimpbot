TGbot = require('node-telegram-bot-api')
Program = require('./app/program')
Subscription = require('./app/subscription')
require('./app/helpers')

token = config.app.token
bot = new TGbot(token, {polling: true})
console.log(token)



bot.on 'message', (msg) ->
  console.log(msg)

#  /programs
  if msg.text == '/programs'
    programs = new Program
    programs.search().then((body)->
      if body.programs.length > 0
        str = ''
        str+= "Вам доступны следующие программы:\n------------------\n"
        for _,v of body.programs
          console.log(body.programs)
          str+="ID:#{v.id} - *#{v.title}*\n#{v.description}\n"
          str+="Всего дней - #{v.program_days.length}\n"
          str+="------------------\n"
        str+= "Наберите */sign ID*, чтобы подписаться на программу"
        bot.sendMessage msg.from.id, str, {parse_mode: 'Markdown'}

      else
        bot.sendMessage(msg.from.id, "Нет доступных программ")
    ).catch (err) ->
      bot.sendMessage(msg.from.id, 'Ошибочка вышла(' + err)


  #   /sign
  if msg.text.startsWith '/sign'
    id = msg.text.split(" ")[1]
    subscription = new Subscription
    subscription.sign(id, msg.from.id).then((body)->
      str= "Поздравляем! Вы подписались на програму №#{body.program_id}\nСтарт #{body.start_date}"
      bot.sendMessage msg.from.id, str
    ).catch (err) ->
      bot.sendMessage(msg.from.id, 'Ошибочка вышла(' + err)

