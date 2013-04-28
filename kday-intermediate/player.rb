require_relative 'scenario'
require_relative 'brain'

class Player
  def play_turn(warrior)
    Brain.decide(Scenario.build(warrior)).perform(warrior)
  end
end
