class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]


  # GET /comments/new
  def new
    @comment = Comment.new(:parent_id => params[:parent_id],:article_id => params[:article_id])
  end


  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        @article = Article.find_by_id(params[:comment][:article_id])
        @comments = @article.comments.order("created_at") if @article.present?
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
        format.js{}
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.js{}
      end
    end
  end


  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      @article = Article.find_by_id(params[:article_id])
      @comments = @article.comments.order("created_at") if @article.present?
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      format.js {}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:body,:article_id,:parent_id)
  end
end
