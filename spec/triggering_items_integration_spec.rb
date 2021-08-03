# frozen_string_literal: true

require 'capybara/rspec'

require './app'
require 'room'
require 'item'
require 'inventory'

Capybara.app = Sinatra::Application
set(show_exceptions: false)

Capybara.save_path = '~/tmp'

describe('Exit room', type: :feature) do
  before :each do
    Room.clear
    Inventory.flush

    @enterance = Room.new 'There are some items.'
    @enterance.save

    @exit_trigger = Item.new(type: 'trigger', detail: 'it reveals way to exit')
    @exit_trigger.save

    Inventory.add_item_id @exit_trigger.id

    visit "/rooms/#{@enterance.id}"
  end

  context('Triggering item is in inventory') do
    it 'there is the message about exit' do
      expect(page).to have_content 'EXIT sighn'
    end
  end
end
