# frozen_string_literal: true

require 'room'

describe('Room#create', type: :feature) do
  context 'from the existing room' do
    before :each do
      Room.clear
      
      @enterance = Room.new 'This is the Enterance'
      @enterance.save
      @description = 'Brand new Room'

      visit "/rooms/#{@enterance.id}"

      click_on 'Digg Next Room'
      fill_in 'description',	with: @description
      click_on 'Finish!'
    end

    it 'redirect to new room page' do
      expect(page).to have_content @description
    end

    it 'has a link on the ancesstor`s page' do
      click_on "Door ##{@enterance.id}"
      expect(page).to have_content @enterance.description
    end
  end
end
