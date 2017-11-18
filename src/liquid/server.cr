class Liquid::Server
  def initialize(@scheduler : Scheduler)
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

  def data
    @scheduler.data
  end

  def start
    server = HTTP::Server.new("127.0.0.1", 8080, [
      HTTP::WebSocketHandler.new { |socket| open(socket) },
      JSONHandler.new { |context| context.response.print data },
      IndexHandler.new,
      HTTP::StaticFileHandler.new("./assets/"),
    ]).listen
  end
end
