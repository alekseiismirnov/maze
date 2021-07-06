require 'item'

describe Item do
  context 'Item#all' do
    it 'return [] if there is no objects' do
      Item.clear
      expect(Item.all).to eq []
    end
  end
end
