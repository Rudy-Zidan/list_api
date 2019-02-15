require "test_helper"

class ItemTest < ActiveSupport::TestCase
  describe 'Associations' do
    let(:item) { Item.first }

    it 'belongs_to a list' do
      assert item.list
    end
  end

  describe 'Validations' do
    it 'should belongs_to a list' do
      item = Item.create(title: 'Test')
      assert_equal item.valid?, false
      assert_equal item.errors.count, 1
      assert_equal item.errors.messages[:list], ["must exist"]
    end

    it 'should have a title' do
      item = Item.create(list: List.first)
      assert_equal item.valid?, false
      assert_equal item.errors.count, 1
      assert_equal item.errors.messages[:title], ["can't be blank"]
    end
  end
end
