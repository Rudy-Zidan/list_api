require "test_helper"

class ListTest < ActiveSupport::TestCase
  describe 'Associations' do
    let(:list) { List.first }

    it 'has many items' do
      assert_equal list.items.count, 1
    end
  end

  describe 'Validations' do
    it 'should have a name' do
      list = List.create
      assert_equal list.valid?, false
      assert_equal list.errors.count, 1
      assert_equal list.errors.messages[:name], ["can't be blank"]
    end
  end
end
