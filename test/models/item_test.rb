require "test_helper"

class ItemTest < ActiveSupport::TestCase
  describe 'Associations' do
    let(:item) { Item.first }

    it 'belongs_to list' do
      assert item.list
    end
  end
end
