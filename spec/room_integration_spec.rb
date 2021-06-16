# frozen_string_literal: true

require 'capybara/rspec'

require './app'
require 'room'

Capybara.app = Sinatra::Application
set(show_exceptions: false)

describe('Room view', type: :feature) do
  before :each do
    @enterance = Room.new('Enterance here', [2], 1)
    @enterance.save
    @room = Room.new('It`s a Passage', [1, 3], 2)
    @room.save
    @exit = Room.new('Exit here', [2], 3)
  end
  context 'for passage room' do
    before :each do
      visit '/rooms/2'
    end

    it 'has a description' do
      expect(page).to have_content @room.description
    end

    it 'has links to other pages' do
      @room.doors.each do |id|
        expect(page).to have_content "Door #{id}"
      end
    end
  end
end
