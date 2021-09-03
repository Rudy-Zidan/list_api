# frozen_string_literal: true

require 'test_helper'

class ListsControllerTest < ActionDispatch::IntegrationTest
  describe 'GET #index' do
    let(:list) { List.first }

    before do
      get lists_path
    end

    test 'should respond with 200' do
      assert_response :success
    end

    test 'response body' do
      response_body = JSON.parse(response.body).first

      assert_equal response_body['id'], list.id
      assert_equal response_body['active_items'][0]['id'], list.items[0].id
    end
  end

  describe 'GET #trash' do
    let(:list) { List.first }

    before do
      list.soft_delete!
      get trash_lists_path
    end

    test 'should respond with 200' do
      assert_response :success
    end

    test 'response body' do
      response_body = JSON.parse(response.body).first

      assert_equal response_body['id'], list.id
      assert_equal response_body['items'][0]['id'], list.items[0].id
    end
  end

  describe 'Get #show' do
    let(:list) { List.first }

    test 'respond with 200 with deleted_at equal to nil' do
      get list_path(list)

      assert_response :success
      response_body = JSON.parse(response.body)

      assert_equal response_body['id'], list.id
    end

    test 'respond with 200 with soft deleted list' do
      list.soft_delete!
      get list_path(list)

      assert_response :success
      response_body = JSON.parse(response.body)

      assert_equal response_body['id'], list.id
    end
  end

  describe 'POST #create' do
    test 'create a list' do
      params = {
        name: 'Test 2',
        items_attributes: [
          {
            title: 'Test item',
            description: 'This is a test'
          }
        ]
      }

      post lists_path, params: params

      assert_response :created
      response_body = JSON.parse(response.body)
      list = List.last
      assert_equal response_body['id'], list.id
    end

    test 'failed to create due to validation errors' do
      params = {
        items_attributes: [
          {
            description: 'This is a test'
          },
          {
            description: 'This is a test'
          }
        ]
      }

      post lists_path, params: params

      assert_response :unprocessable_entity
      response_body = JSON.parse(response.body)

      assert_equal response_body['errors'][0]['field'], 'items.title'
      assert_equal response_body['errors'][0]['detailed_message'], "can't be blank"
      assert_equal response_body['errors'][1]['field'], 'name'
      assert_equal response_body['errors'][1]['detailed_message'], "can't be blank"
    end
  end

  describe 'PUT #update' do
    let(:list) { List.first }
    let(:item) { Item.first }

    test 'update a list' do
      params = {
        id: list.id,
        name: 'Test 2',
        items_attributes: [
          {
            id: item.id,
            title: 'Test item',
            description: 'This is a test'
          }
        ]
      }

      put list_path(list), params: params

      assert_response :success
      response_body = JSON.parse(response.body)
      list = List.last
      assert_equal response_body['id'], list.id
    end

    test 'failed to create due to validation errors' do
      params = {
        id: list.id,
        name: '',
        items_attributes: [
          {
            id: item.id,
            title: '',
            description: 'This is a test'
          }
        ]
      }

      put list_path(list), params: params

      assert_response :unprocessable_entity
      response_body = JSON.parse(response.body)

      assert_equal response_body['items.title'], ["can't be blank"]
      assert_equal response_body['name'], ["can't be blank"]
    end
  end

  describe 'DELETE #destroy' do
    let(:list) { List.first }

    test 'should soft delete a list with response code 200' do
      delete list_path(list)

      assert_response :success
      response_body = JSON.parse(response.body)

      assert response_body['deleted_at']
    end
  end

  describe 'PUT #restore' do
    let(:list) { List.first }

    test 'should restore a soft deleted list with response code 200' do
      list.soft_delete!
      put restore_list_path(list)

      assert_response :success
      response_body = JSON.parse(response.body)

      assert_nil response_body['deleted_at']
    end
  end

  describe 'DELETE #delete' do
    let(:list) { List.first }

    test 'should delete a list permanent with response code 200' do
      delete delete_list_path(list)

      assert_response :success
      assert_nil List.with_deleted.find_by_id(list.id)
    end
  end
end
