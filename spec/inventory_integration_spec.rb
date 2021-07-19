# frozen_string_literal: true

require 'capybara/rspec'

require './app'
require 'room'
require 'item'
require 'inventory'

Capybara.app = Sinatra::Application
set(show_exceptions: false)

Capybara.save_path = '~/tmp'

describe(Inventory, type: :feature) do
  before :each do
    Room.clear

    @enterance = Room.new 'There are some items here'
    @enterance.save

    visit "/rooms/#{@enterance.id}"
  end

  context 'whatever it is' do
    it 'there is a section inventory on the room page' do
      expect(page).to have_content 'Inventory'
    end
  end
end
