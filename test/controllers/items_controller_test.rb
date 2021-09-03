# frozen_string_literal: true

require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  describe 'GET #trash' do
    let(:item) { Item.first }

    before do
      item.soft_delete!
      get trash_items_path
    end

    test 'should respond with 200' do
      assert_response :success
    end

    test 'response body' do
      response_body = JSON.parse(response.body).first

      assert_equal response_body['id'], item.id
      assert response_body['deleted_at']
      assert_equal response_body['list']['id'], item.list.id
    end
  end

  describe 'DELETE #destroy' do
    let(:item) { Item.first }

    test 'should soft delete aan item with response code 200' do
      delete item_path(item)

      assert_response :success
      response_body = JSON.parse(response.body)

      assert response_body['deleted_at']
    end
  end

  describe 'PUT #restore' do
    let(:item) { Item.first }

    test 'should restore a soft deleted item with response code 200' do
      item.soft_delete!
      put restore_item_path(item)

      assert_response :success
      response_body = JSON.parse(response.body)

      assert_nil response_body['deleted_at']
    end
  end

  describe 'DELETE #delete' do
    let(:item) { Item.first }

    test 'should delete an item permanent with response code 200' do
      delete delete_item_path(item)

      assert_response :success
      assert_nil Item.with_deleted.find_by_id(item.id)
    end
  end
end
