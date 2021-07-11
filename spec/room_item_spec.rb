# frozen_string_literal: true

require 'room'
require 'item'

describe Room do
  context 'Room#all_items' do
    before :each do
      @room = Room.new('Some room', [1, 2], Room.free_id)
    end
    it 'returns [] if there is no items in the room' do
      expect(@room.all_items).to eq []
    end

    it 'returns a list of items' do
      items = [
        Item.new(type: 'something', detail: 'have no idea what it is').save,
        Item.new(type: 'whatever', detail: 'something different').save
      ]
      @room.put_item items[0]
      @room.put_item items[1]
      expect(@room.all_items).to eq items
    end
  end
end
