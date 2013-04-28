require_relative 'knowledge'
require_relative 'helpers'

class Brain
  attr_accessor :knowledge

  def initialize
    self.knowledge = Knowledge.all
  end

  def decide(scenario)
    sorted_lessons = self.knowledge.sort_by { |lesson| -lesson.applicability.call(scenario) }
    most_applicable_lesson = sorted_lessons.first

    if most_applicable_lesson.applicability.call(scenario) < 0.01
      raise "I don't have any experience with this scenario!"
    else
      print_decision(sorted_lessons, scenario)
      return most_applicable_lesson.action.call(scenario)
    end
  end
end
