class Api::ArticlesController < ApplicationController
  before_action :set_api_article, only: %i[show update destroy]
  before_action :authenticate_user!, except: %i[index]
  before_action :is_admin?, only: %i[destroy update edit show]

  # GET /api/articles
  def index
    @api_articles = Api::Article.all

    render json: @api_articles
  end

  # GET /api/articles/1
  def show
    render json: @api_article
  end

  # POST /api/articles
  def create
    @api_article = Api::Article.new(api_article_params)
    @api_article.user_id= current_user.id

    if @api_article.save
      render json: @api_article, status: :created, location: @api_article
    else
      render json: @api_article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/articles/1
  def update
    if @api_article.update(api_article_params)
      render json: @api_article
    else
      render json: @api_article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/articles/1
  def destroy
    @api_article.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_article
      @api_article = Api::Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_article_params
      params.require(:api_article).permit(:title, :content)
    end

    def is_admin?
      if @api_article.user_id != current_user.id
       render json: { error: 'Unauthorized', detail: "Can only do this to one's own article" }
      end
    end
end
