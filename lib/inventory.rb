# frozen_string_literal: true

# maintain list of item ids, carried by the player
class Inventory
  attr_reader :item_ids

  @item_ids = []

  def self.flush
    @item_ids = []
  end

  def self.add_item_id(item_id)
    @item_ids << item_id
  end

  def self.remove_item_id(item_id)
    @item_ids.delete item_id
  end

  def self.all_items
    @item_ids.map { |id| Item.find id }
  end

  def self.any?(id)
    @item_ids.any? id
  end
end
