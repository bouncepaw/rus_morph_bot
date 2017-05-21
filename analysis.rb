require "nokogiri"

def to_text(input)
  input.css("br").each { |node| node.replace("\n") }
  input = input.text
  log "Parsed analysis: #{input}"
  return input
end

def do_morpheme_analysis(word)
  error_message = "Во время обработки вашего запроса произошла ошибка. " <<
  "Скорее всего, такого слова просто нет в базе данных, либо эта база " <<
  "сейчас не работает. Может быть, случилось что-то с ботом. " <<
  "Попробуйте другое слово!"

  log "Started morpheme analysis of word #{word}"
  return error_message if word.nil?
  uri = "http://morphemeonline.ru/#{URI.encode word[0].upcase}/" <<
  "#{URI.encode word}"

  begin
    analysis = Nokogiri::HTML(open uri).css ".col-md-9 p"
    log "Opened page #{uri}"
    log "Got analysis: #{analysis}"
    return to_text analysis
  rescue
    log "While opening page #{uri}, an error has occured.", "*"
    return error_message
  end
end
