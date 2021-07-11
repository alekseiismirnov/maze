# frozen_string_literal: true

require 'room'
require 'item'

describe Room do
  context 'Room#all_items' do
    it 'returns [] if there is no items in the room' do
      room = Room.new('Some room', [1, 2], Room.free_id)
      expect(room.all_items).to eq []
    end
  end
end
