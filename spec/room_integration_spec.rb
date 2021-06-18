# frozen_string_literal: true

require 'capybara/rspec'

require './app'
require 'room'

Capybara.app = Sinatra::Application
set(show_exceptions: false)

Capybara.save_path = '~/tmp/'

describe('Room view', type: :feature) do
  before :each do
    @enterance = Room.new('Enterance here', [2], 1)
    @enterance.save
    @room = Room.new('It`s a Passage', [1, 3], 2)
    @room.save
    @exit = Room.new('Exit here', [2], 3)
    @exit.save
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
        expect(page).to have_content "Door ##{id}"
      end
    end

    it 'is possible go through from the enterance to the exit' do
      visit '/rooms/1'
      click_on 'Door #2'
      click_on 'Door #3'
      expect(page).to have_content 'Exit here'
    end
  end
end
