# frozen_string_literal: true

describe 'Room#delete' do
  context 'there is saved room' do
    before :each do
      Room.clear
      @saved_room = Room.new('Common room', [1])
      @saved_room.save
    end

    it 'can not be found after #delete' do
      @saved_room.delete
      room = Room.find @saved_room.id
      expect(room).to eq nil
    end

    it '.all returns zero-length list' do
      @saved_room.delete
      expect(Room.all.length).to eq 0
    end
  end
end
