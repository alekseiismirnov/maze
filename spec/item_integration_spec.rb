require 'capybara/rspec'
require './app'
require 'room'
require 'item'

Capybara.app = Sinatra::Application
set(show_exceptions: false)

Capybara.save_path = '~/tmp'

describe(Item, type: :feature) do
  before :each do
    Room.clear

    @enterance = Room.new 'This is the Enterance'
    @enterance.save
  end

  context 'there are some items in the room' do
    before :each do
      @clock = Item.new(type: 'clock', detail: 'rustic cookoo clock in perfect condition')
      @key = Item.new(type: 'key', detail: 'seems there is no lock for it anywhere')
      
      @clock.save
      @key.save
      @enterance.put_item @clock
      @enterance.put_item @key
    end

    it 'are items type in the room' do
      visit "/rooms/#{@enterance.id}"
      expect(page).to have_content @clock.type
    end
  end
  
end