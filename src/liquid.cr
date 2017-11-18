require "http/server"
require "./liquid/*"

scheduler = Liquid::Scheduler.instance
spawn { scheduler.start }

class TimeJob < Liquid::Job
  def run
    send(Time.now.to_s)
  end
end

scheduler.every 1.second, TimeJob

sleep
