require "json"

abstract class Liquid::Job
  def initialize(@server : Server, @interval : Time::Span, @name : String = self.class.name)
    @data = JSON.build do |json|
      json.object do
        json.field "name", @name
      end
    end

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

  def send(payload : JSON::Any | String)
    @data = JSON.build do |json|
      json.object do
        json.field "name", @name
        json.field "payload", payload
      end
    end
    @server.send(@data)
  end

  def data
    @data
  end

  abstract def run
end
