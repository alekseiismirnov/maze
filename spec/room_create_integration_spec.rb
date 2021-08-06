# frozen_string_literal: true

require 'capybara/rspec'
require './app'
require 'room'

Capybara.app = Sinatra::Application
set(show_exceptions: false)

Capybara.save_path = '~/tmp/'

describe('Room#create', type: :feature) do
  context 'from the existing room' do
    before :each do
      Room.clear
      Inventory.flush

      @enterance = Room.new 'This is the Enterance'
      @enterance.save
      @description = 'Brand new Room'

      visit "/rooms/#{@enterance.id}"

      click_on 'Digg Next Room'
      fill_in 'description',	with: @description
      click_on 'Finish!'

      @room_id = page.current_url.split('/').last.to_i
    end

    it 'redirect to new room' do
      expect(page).to have_content @description
    end

    it 'has a door to the ancesstor' do
      click_on "Door ##{@enterance.id}"
      expect(page).to have_content @enterance.description
    end

    it 'adds new door to the ancesstor' do
      click_on "Door ##{@enterance.id}"
      click_on "Door ##{@room_id}"

      expect(page.find(class: 'description').text).to have_content @description
    end
  end
end
