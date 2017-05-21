%w(open-uri telegram/bot).each { |f| require f }
%w(analysis monkeypatching).each { |f| require_relative f }

def log(msg, marker = "-")
  puts "(#{marker}) #{Time.now} #{msg}"
end

log "Started RusMorphBot"

Telegram::Bot::Client.run(ARGV[0]) do |bot|
  bot.listen do |message|
    next unless ARGV[1] == nil
    if message.text == "/help"
      log "/help was requested by #{message.from.first_name}"
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Отправь `/2 любое-слово`, и бот сделает морфемный разбор."
      )
    elsif message.text[0..2] == "/1 "
      log "Phonetic analysis was requested by #{message.from.first_name}"
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Фонетический разбор ещё не реализован, но скоро будет."
      )
    elsif message.text[0..2] == "/2 "
      log "Morpheme analysis was requested by #{message.from.first_name}"
      bot.api.send_message(
        chat_id: message.chat.id,
        text: do_morpheme_analysis(message.text[3..-1])
      )
    elsif message.text[0..2] == "/3 "
      log "Morphologic analysis was requested by #{message.from.first_name}"
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Морфологический разбор ещё не реализован, но скоро будет."
      )
    end
  end
end
