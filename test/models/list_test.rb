require "test_helper"

class ListTest < ActiveSupport::TestCase
  describe 'Associations' do
    let(:list) { List.first }
    
    it 'has many items' do
      assert_equal list.items.count, 1
    end
  end
end
