# frozen_string_literal: true
require 'capybara/rspec'
require './app'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('Static prototype', type: :feature) do
  context 'Enterance' do
    before :each do
      visit 'static/1'
    end
    it 'is a page describing enterance' do
      expect(page).to have_content('Enterance here')
    end
    it 'has a link `Door #1` to the Hall' do
      click_on 'Door #1'
      expect(page).to have_content('The Main Hall')
    end
  end

  context 'Walkthrough' do
    it 'is possible to go to `Dead End` and then to the exit' do
      path = ['Door #1', 'Door #1', 'Door #0', 'Door #2', 'Door #1']

      visit 'static/1'
      path.each do |door|
        click_on door
      end

      expect(page).to have_content('EXIT') 
    end
  end
end
