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
      assert_equal response_body['items'][0]['id'], list.items[0].id
    end
  end

  describe 'GET #trash' do
    let(:list) { List.first }

    before do
      list.destroy
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
end
