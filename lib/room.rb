# frozen_string_literal: true

# description: text, doors: list of id`s
class Room
  attr_accessor :description, :doors
  def initialize
    @doors = []
  end
end
