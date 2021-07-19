# frozen_string_literal: true

# description: text, doors: list of id`s
class Room
  attr_accessor :description, :doors, :id, :item_ids

  @rooms = {}
  @total_rows = 0

  def initialize(*args)
    @description, @doors, @id = args
    @doors ||= []
    @id ||= self.class.free_id
    @item_ids = [] # wanna to change code before?
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
    @rooms[room.id].item_ids = room.item_ids.clone
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
    @description = params[:description] unless params[:description].nil?
    @doors = params[:doors] unless params[:doors].nil?

    save
  end

  def delete
    self.class.remove_room id
  end

  def to_hash
    {
      id: @id,
      description: @description,
      doors: @doors,
      item_ids: @item_ids
    }
  end

  def all_items
    @item_ids.map { |id| Item.find(id) }
  end

  def put_item(item)
    # we assume item to be saved, exsceptions are not yet learned *smile*
    @item_ids << item.id
    save
  end

  def get_item(item)
    @item_ids.delete item.id
  end
end
