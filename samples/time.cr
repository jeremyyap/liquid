require "./liquid/*"

scheduler = Liquid::Scheduler.instance

class TimeJob < Liquid::Job
  def run
    send(Time.now.to_json)
  end
end

scheduler.every 1.second, TimeJob
scheduler.start
