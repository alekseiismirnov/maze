# frozen_string_literal: true

describe 'Room#delete' do
  context 'there is saved room' do
    before :each do
      Room.clear
      @enterance = Room.new('Enterance')
      @enterance.save

      @saved_room = Room.new('Common room', [@enterance.id])
      @saved_room.save

      @enterance.update(doors: [@saved_room.id])
    end

    it 'can not be found after #delete' do
      @saved_room.delete
      room = Room.find @saved_room.id
      expect(room).to eq nil
    end

    it '.all returns zero-length list after all rooms deleted' do
      Room.all.each(&:delete)
      expect(Room.all.length).to eq 0
    end
  end
end
