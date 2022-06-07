require "test_helper"

class Api::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_comment = api_comments(:one)
  end

  test "should get index" do
    get api_comments_url, as: :json
    assert_response :success
  end

  test "should create api_comment" do
    assert_difference('Api::Comment.count') do
      post api_comments_url, params: { api_comment: { article_id: @api_comment.article_id, content: @api_comment.content } }, as: :json
    end

    assert_response 201
  end

  test "should show api_comment" do
    get api_comment_url(@api_comment), as: :json
    assert_response :success
  end

  test "should update api_comment" do
    patch api_comment_url(@api_comment), params: { api_comment: { article_id: @api_comment.article_id, content: @api_comment.content } }, as: :json
    assert_response 200
  end

  test "should destroy api_comment" do
    assert_difference('Api::Comment.count', -1) do
      delete api_comment_url(@api_comment), as: :json
    end

    assert_response 204
  end
end
