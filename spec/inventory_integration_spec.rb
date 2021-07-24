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

  context 'whatever it is' do
    it 'there is a section inventory on the room page' do
      within('.inventory') do
        expect(page).to have_content 'Inventory'
      end
    end
  end

  context 'if we took one item in the room' do
    before :each do
      @hedgehog = Item.new(type: 'golden hedgehog', detail: 'hedgehog figurine made from the gold')
      @hedgehog.save
      @flag = Item.new(type: 'flag', detail: 'is on')
      @flag.save
      @enterance.put_item @hedgehog
      @enterance.put_item @flag

      visit "/rooms/#{@enterance.id}"

      click_on @hedgehog.type

      click_on 'Take!'
    end

    it 'item will be in the `Inventory` section' do
      within('.inventory') do
        expect(page).to have_content @hedgehog.type
      end
    end

    it 'item will not be in the room' do
      within('.items') do 
        expect(page).to have_no_content @hedgehog.type
      end
    end
  end
end
