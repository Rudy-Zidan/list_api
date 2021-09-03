# frozen_string_literal: true

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test 'belongs_to a list' do
    item = Item.first
    assert item.list
  end

  test 'should belongs_to a list' do
    item = Item.create(title: 'Test')
    assert_not item.valid?
    assert_equal item.errors.count, 1
    assert_equal item.errors.messages[:list], ['must exist']
  end

  test 'should have a title' do
    item = Item.create(list: List.first)
    assert_equal item.valid?, false
    assert_equal item.errors.count, 1
    assert_equal item.errors.messages[:title], ["can't be blank"]
  end

  test 'soft delete an item' do
    item = Item.first
    item.soft_delete!
    assert item.deleted?
  end

  test 'restore a soft deleted item' do
    item = Item.first
    item.soft_delete!
    item.restore!
    assert_not item.deleted?
  end

  test 'really_destroy an item' do
    item = Item.first
    list = item.list
    item.destroy
    assert_not item.persisted?
    assert list.reload
  end
end
