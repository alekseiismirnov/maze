# frozen_string_literal: true

require 'room'

Capybara.app = Sinatra::Application
set(show_exceptions: true)

Capybara.save_path = '~/tmp/'

describe('Room#update', type: :feature) do
  before :each do
    Room.clear
    @description = 'Such a room'
    @new_description = 'Lot of something'
    @doors = [3, 4, 25]
    @id = 100_500
    @room = Room.new(@description, @doors, @id)
    @room.save

    visit "/rooms/#{@id}"

    click_on 'Edit room'

    fill_in 'description',	with: @new_description
    click_on 'Finish!'
  end

  it 'changes the room description' do
    expect(page).to have_content @new_description
  end
end
