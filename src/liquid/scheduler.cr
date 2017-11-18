class Liquid::Scheduler
  def self.instance
    @@instance ||= new
  end

  def every(interval, jobClass)
    jobClass.new(@server, interval)
  end

  def start
    @server.start
  end

  private def initialize
    @server = Liquid::Server.new
  end
end
