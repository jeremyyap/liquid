class Liquid::JSONHandler
  include HTTP::Handler

  def initialize(&@proc : HTTP::Server::Context ->)
  end

  def call(context)
    if context.request.headers["Accept"] == "application/json"
      context.response.content_type = "application/json"
      @proc.call context
    else
      call_next(context)
    end
  end
end
