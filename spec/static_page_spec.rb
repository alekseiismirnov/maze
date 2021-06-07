# frozen_string_literal: true
require 'capybara/rspec'
require './app'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('Static prototype', type: :feature) do
  context 'Enterance' do
    it 'is a page describing enterance' do
      visit('static/1')
      expect(page).to have_content('Enterance here')
    end
  end
end
