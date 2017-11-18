class Liquid::Server
  def initialize
    @sockets = [] of HTTP::WebSocket
  end

  def send(message)
    @sockets.each { |socket| socket.send(message) }
  end

  def open(socket)
    socket.on_close do
      puts "WebSocket closed"
      @sockets.delete(socket)
    end

    @sockets << socket
  end

  def start
    HTTP::Server.new("127.0.0.1", 8080, [
      HTTP::WebSocketHandler.new { |socket| open(socket) },
      HTTP::StaticFileHandler.new("./views/"),
    ]).listen
  end
end
