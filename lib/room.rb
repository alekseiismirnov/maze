# frozen_string_literal: true

# description: text, doors: list of id`s
class Room
  attr_accessor :description, :doors, :id

  @rooms = {}
  @total_rows = 0

  def initialize(*args)
    @description, @doors, @id = args
    @doors ||= []
    @id ||= self.class.free_id
  end

  def self.clear
    @rooms = {}
  end

  def self.all
    @rooms.values
  end

  def self.free_id
    @total_rows += 1
  end

  def self.add_room(room)
    @rooms[room.id] = Room.new(room.description, room.doors, room.id)
  end

  def self.find(id)
    @rooms[id]
  end

  def self.remove_room(id)
    @rooms.delete(id)
  end

  def save
    self.class.add_room self
  end

  def update(params)
    @description = params[:description]
    @doors = params[:doors]
    save
  end

  def delete
    self.class.remove_room id
  end

  def to_hash
    { 
      description: @description,
      doors: @doors
    }
  end  
end
