require "http/server"
require "./liquid/*"

class HelloWorldJob < Liquid::Job
  def run
    puts "hello world"
  end
end

job = HelloWorldJob.new 1.seconds
job.start

def open(ws)
  loop do
    begin
      ws.send(Time.now.to_s)
    rescue IO::Error
      puts "WebSocket closed"
      break
    end
    sleep 1
  end
end

HTTP::Server.new("127.0.0.1", 8080, [
  HTTP::WebSocketHandler.new { |ws| spawn { open(ws) } },
  HTTP::StaticFileHandler.new("./views/"),
]).listen
