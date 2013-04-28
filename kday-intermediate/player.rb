require_relative 'scenario'
require_relative 'brain'

class Player
  attr_accessor :brain

  def initialize
    self.brain = Brain.new()
  end

  def play_turn(warrior)
    scenario = Scenario.build(warrior)
    action = self.brain.decide(scenario)
    action.perform(warrior)
  end
end
