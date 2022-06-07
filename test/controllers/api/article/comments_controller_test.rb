require "test_helper"

class Api::Article::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_article_comment = api_article_comments(:one)
  end

  test "should get index" do
    get api_article_comments_url, as: :json
    assert_response :success
  end

  test "should create api_article_comment" do
    assert_difference('Api::Article::Comment.count') do
      post api_article_comments_url, params: { api_article_comment: { content: @api_article_comment.content } }, as: :json
    end

    assert_response 201
  end

  test "should show api_article_comment" do
    get api_article_comment_url(@api_article_comment), as: :json
    assert_response :success
  end

  test "should update api_article_comment" do
    patch api_article_comment_url(@api_article_comment), params: { api_article_comment: { content: @api_article_comment.content } }, as: :json
    assert_response 200
  end

  test "should destroy api_article_comment" do
    assert_difference('Api::Article::Comment.count', -1) do
      delete api_article_comment_url(@api_article_comment), as: :json
    end

    assert_response 204
  end
end
