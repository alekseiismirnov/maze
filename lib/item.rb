# frozen_string_literal: true

# Items, could be founded in the maze
class Item
  attr_reader :id, :type, :detail

  @items = {}
  @total_rows = 0

  def initialize(params)
    @type = params[:type]
    @detail = params[:detail]
    @id = params[:id]
  end

  def self.clear
    @items = {}
  end

  def self.all
    @items.values
  end

  def self.free_id
    @total_rows += 1
  end

  def self.add_item(item)
    @items[item.id] = item
  end

  def ==(other)
    @type == other.type && @detail == other.detail
  end

  def save
    id = self.class.free_id
    self.class.add_item Item.new(type: @type, detail: @detail, id: id)
  end
end
