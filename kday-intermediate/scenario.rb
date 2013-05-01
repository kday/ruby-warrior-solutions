class Scenario
  attr_accessor :warrior, :left, :right, :forward, :backward, :warrior_health, :distance_to_stairs, :direction_of_stairs, :filled_spaces, :direction_of_ticking, :spaces_toward_ticking, :targeted_enemy_direction, :targeted_captive_direction
  DIRECTIONS = [:left, :right, :forward, :backward]

  def self.build(warrior)
    scenario = Scenario.new()

    DIRECTIONS.each do |direction|
      scenario.send(direction.to_s + "=", warrior.feel(direction))
    end

    # These methods may not exist for a given level
    scenario.warrior_health = warrior.health
    scenario.direction_of_stairs = warrior.direction_of_stairs
    scenario.filled_spaces = warrior.listen


    if scenario.all_spaces('Thick Sludge').count > 0
      scenario.targeted_enemy_direction = warrior.direction_of(scenario.all_spaces('Thick Sludge')[0])
    elsif scenario.all_spaces('Sludge').count > 0
      scenario.targeted_enemy_direction = warrior.direction_of(scenario.all_spaces('Sludge')[0])
    end

    if scenario.all_spaces('Captive').count > 0
      scenario.targeted_captive_direction = warrior.direction_of(scenario.all_spaces('Captive')[0])
    else
      scenario.targeted_captive_direction = nil
    end

    if scenario.all_spaces('ticking?').count > 0
      scenario.direction_of_ticking = warrior.direction_of(scenario.all_spaces('ticking?')[0])
      scenario.spaces_toward_ticking = warrior.look(scenario.direction_of_ticking)
    else
      scenario.direction_of_ticking = nil
      scenario.spaces_toward_ticking = []
    end
    return scenario
  end

  def neighbors(filter = nil)
    spaces = []
    DIRECTIONS.each do |direction|
      space = self.send(direction)
      if filter.nil?
        spaces.push(direction)
      elsif space.respond_to?(filter) and space.send(filter)
        spaces.push(direction)
      elsif space.to_s == filter
        spaces.push(direction)
      end
    end
    return spaces
  end

  def all_spaces(filter = nil)
    spaces = []
    self.filled_spaces.each do |space|
      if filter.nil?
        spaces.push(space)
      elsif space.respond_to?(filter) and space.send(filter)
        spaces.push(space)
      elsif space.to_s == filter
        spaces.push(space)
      end
    end
    return spaces
  end

  def neighbor(direction)
    if direction.nil?
      return nil
    else
      return self.send(direction)
    end
  end

  def any_unbound_enemy_neighbor_direction
    unbound_neighbors = self.neighbors('enemy?')
    if unbound_neighbors.count > 0
      return unbound_neighbors[0]
    else
      return nil
    end
  end

  def any_enemy_neighbor_direction
    if self.right.to_s == ('Sludge' or 'Thick Sludge')
      return :right
    elsif self.forward.to_s == ('Sludge' or 'Thick Sludge')
      return :forward
    elsif self.left.to_s == ('Sludge' or 'Thick Sludge')
      return :left
    elsif self.backward.to_s == ('Sludge' or 'Thick Sludge')
      return :backward
    end
    return nil
  end

  def any_enemies?
    if self.all_spaces('Sludge').count > 0 or self.all_spaces('Thick Sludge').count > 0
      return true
    else
      return false
    end
  end
end
