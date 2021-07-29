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
    Inventory.flush

    @enterance = Room.new 'There are some items here'
    @enterance.save

    visit "/rooms/#{@enterance.id}"
  end

  context 'if we drop one item in the room' do
    before :each do
      @figurine = Item.new(type: 'bronze figurine', detail: 'Karlheinz Stockhausen figurine made from the bronze')
      @figurine.save
      @cat = Item.new(type: 'cat', detail: 'fluffy kitty')
      @cat.save
      @enterance.put_item @figurine
      Inventory.add_item_id @cat.id

      visit "/rooms/#{@enterance.id}"

      click_on 'Drop'
    end

    it 'item will be in the room' do
      within('.items') do
        expect(page).to have_content @cat.type
      end
    end

    it 'item will not be in the inventory' do
      within('.inventory') do
        expect(page).to have_no_content @cat.type
      end
    end
  end
end
