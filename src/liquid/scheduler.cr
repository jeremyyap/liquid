require "json"

class Liquid::Scheduler
  def self.instance
    @@instance ||= new
  end

  def every(interval, jobClass)
    job = jobClass.new(server, interval)
    @jobs << job
  end

  def start
    server.start
  end

  def data
    @jobs.map(&.data).to_json
  end

  def server
    @server ||= Server.new(self)
  end

  private def initialize
    @jobs = [] of Job
  end
end
