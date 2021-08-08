# frozen_string_literal: true

require 'capybara/rspec'

require './app'
require 'room'

Capybara.app = Sinatra::Application
set(show_exceptions: false)

Capybara.save_path = '~/tmp'

# #add_lever(lever_id, door_id, position) position - number 0-9
# initial value always 0
# #set_lever(lever_id, position)
#
# #levers_ids

describe('Levers', type: :feature) do
  before :each do
    @doors = [5, 10, 13, 24, 98]

    Room.clear
    @hall = Room.new 'This is a hall with many doors'
    @hall.save

    @hall.update(doors: @doors)
  end

  context 'There is no levers' do
    it 'list of avaiable doors is same as the list of all doors' do
      expect(@hall.doors.sort).to eq @hall.all_doors.sort
    end
  end
end
