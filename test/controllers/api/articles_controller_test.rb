require "test_helper"

class Api::ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_article = api_articles(:one)
  end

  test "should get index" do
    get api_articles_url, as: :json
    assert_response :success
  end

  test "should create api_article" do
    assert_difference('Api::Article.count') do
      post api_articles_url, params: { api_article: { content: @api_article.content, title: @api_article.title } }, as: :json
    end

    assert_response 201
  end

  test "should show api_article" do
    get api_article_url(@api_article), as: :json
    assert_response :success
  end

  test "should update api_article" do
    patch api_article_url(@api_article), params: { api_article: { content: @api_article.content, title: @api_article.title } }, as: :json
    assert_response 200
  end

  test "should destroy api_article" do
    assert_difference('Api::Article.count', -1) do
      delete api_article_url(@api_article), as: :json
    end

    assert_response 204
  end
end
