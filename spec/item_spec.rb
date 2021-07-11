# frozen_string_literal: true

require 'item'

describe Item do
  before :each do
    @catalog = (1..10).to_a.map do |i|
      { type: "Item ##{i}", detail: "Description of the item ##{i}" }
    end

    @items = @catalog.map { |record| Item.new(record) }
    @items.each(&:save)
  end

  context 'Item#all' do
    it 'return [] if there is no objects' do
      Item.clear
      expect(Item.all).to eq []
    end

    it '#all returns all saved items' do
      expect(Item.all).to eq @items # should we sort?
    end
  end
end
