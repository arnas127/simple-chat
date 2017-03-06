require 'net/http'

class Translator
  DIALECTS = %w(valley yoda binary)

  def self.translate(input, dialect)
    raise 'Dialect unsupported' unless dialect.in? DIALECTS
    response = do_request(input, dialect)
    parse_response(response)
  end

  private

  def self.do_request(input, dialect)
    input = URI.encode(input)
    uri = URI("http://www.degraeve.com/cgi-bin/babel.cgi?d=#{dialect}&url=&w=#{input}")
    Net::HTTP.get(uri)
  end

  def self.parse_response(response)
    content = Nokogiri::HTML(response).xpath("//blockquote//p").text
    content.reverse.chop.reverse # cur new line from the beginning
  end
end
