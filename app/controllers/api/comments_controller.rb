class Api::CommentsController < ApplicationController
  before_action :set_api_comment, only: [:show, :update, :destroy, :is_admin?]
  before_action :authenticate_user!
  before_action :is_admin?, except: %i[create index]

  def index
    @api_comments = Api::Comment.all.filter{|comment|  comment.article_id == params[:article_id].to_i}
    render json: { comments: @api_comments }
  end

  def create
    @api_comment = Api::Comment.new(api_comment_params)
    @api_comment.article_id = params[:article_id]
    @api_comment.user_id = current_user.id
    if @api_comment.save
      render json: @api_comment, status: :created
    else
      render json: @api_comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/comments/1
  def update
    if @api_comment.update(api_comment_params)
      render json: @api_comment
    else
      render json: @api_comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/comments/1
  def destroy
    @api_comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_comment
      @api_comment = Api::Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_comment_params
      params.require(:api_comment).permit(:content)
    end

    def is_admin?
      if @api_comment.user_id != current_user.id
       render json: { error: 'Unauthorized', detail: "Can only do this to one's own comment" }
      end
    end


end
