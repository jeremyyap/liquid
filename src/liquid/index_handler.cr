require "http"

class Liquid::IndexHandler
  include HTTP::Handler

  def initialize
  end

  def call(context)
    if context.request.path == "/"
      File.open("./assets/index.html") do |file|
        IO.copy(file, context.response)
      end
    else
      call_next(context)
    end
  end
end
