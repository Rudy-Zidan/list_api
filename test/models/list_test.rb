# frozen_string_literal: true

require 'test_helper'

class ListTest < ActiveSupport::TestCase
  test 'has many items' do
    list = List.first
    assert_equal list.items.count, 1
  end

  test 'should have a name' do
    list = List.create
    assert_not list.valid?
    assert_equal list.errors.count, 1
    assert_equal list.errors.messages[:name], ["can't be blank"]
  end

  test 'soft delete a list' do
    list = List.first
    list.soft_delete!
    assert list.deleted?
  end

  test 'restore a soft deleted list' do
    list = List.first
    list.soft_delete!
    list.restore!
    assert_not list.deleted?
  end

  test 'really_destroy a list' do
    list = List.first
    list.destroy
    assert_not list.persisted?
    assert Item.where(list_id: list.id).empty?
  end
end
