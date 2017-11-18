abstract class Liquid::Job
  def initialize(@server : Liquid::Server, @interval : Time::Span)
    start
  end

  def start
    spawn do
      loop do
        run
        sleep @interval
      end
    end
  end

  def send(message)
    @server.send(message)
  end

  abstract def run
end
