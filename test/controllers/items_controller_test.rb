require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  describe 'GET #trash' do
    let(:item) { Item.first }

    before do
      item.destroy
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
end
