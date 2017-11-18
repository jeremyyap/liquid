abstract class Liquid::Job
  def initialize(@interval : Time::Span)
  end

  def start
    spawn do
      loop do
        run
        sleep @interval
      end
    end
  end

  abstract def run
end
