# frozen_string_literal: true

require 'room'
require 'item'

describe Room do
  before :each do
    @room = Room.new('Some room', [1, 2], Room.free_id)
  end

  context 'No items in the room' do
    it 'Room#all_items returns [] if there is no items in the room' do
      expect(@room.all_items).to eq []
    end
  end

  context 'If there are some items in the room' do
    before :each do
      @items = [
        Item.new(type: 'something', detail: 'have no idea what it is').save,
        Item.new(type: 'whatever', detail: 'something different').save
      ]
      @room.put_item @items[0]
      @room.put_item @items[1]
    end

    it 'Room#all_returns a list of items' do
      expect(@room.all_items).to eq @items
    end
  end
end
