require_relative 'knowledge'
require_relative 'helpers'

class Brain
  def decide(scenario)
    sorted_lessons = Knowledge.all.sort_by { |lesson| -lesson.applicability(scenario) }
    most_applicable_lesson = sorted_lessons.first

    if most_applicable_lesson.applicability(scenario) < 0.01
      raise "I don't have any experience with this scenario!"
    else
      print_decision(sorted_lessons, scenario)
      return most_applicable_lesson.respond(scenario)
    end
  end
end
