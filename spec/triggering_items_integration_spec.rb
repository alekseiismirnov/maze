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
    Item.clear

    @enterance = Room.new 'There are some items.'
    @enterance.save

    @exit_trigger = Item.new(type: 'trigger', detail: 'it reveals way to exit')
    @exit_trigger.save

    @cap = Item.new(type: 'cap', detail: 'the magic cap')
    @cap.save

    @enterance.add_trigger @exit_trigger

    Inventory.add_item_id @cap.id
  end

  context('Triggering item is in inventory') do
    before :each do
      Inventory.add_item_id @exit_trigger.id
      visit "/rooms/#{@enterance.id}"
    end

    it 'there is the message about exit' do
      within '.description' do
        expect(page).to have_content 'EXIT sighn'
      end
    end
  end

  context('There is no triggering item in invetnory') do
    before :each do
      visit "/rooms/#{@enterance.id}"
    end

    it 'there is no exit message' do
      within '.description' do
        expect(page).to have_no_content 'EXIT sighn'
      end
    end
  end
end
