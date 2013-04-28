class Lesson
  attr_accessor :description, :applicability, :action

  def initialize(description)
    self.description = description
  end

  def scenario_applicability(proc)
    self.applicability = proc
  end

  def take_action(proc)
    self.action = proc
  end
end
