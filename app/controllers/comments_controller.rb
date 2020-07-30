class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])

    @comment = comment_params
    @comment[:user] = current_user
    @comment = @article.comments.create(@comment)

    logger.debug @comment.attributes.inspect

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])

    authorize @comment

    @comment.destroy
  
    respond_to do |format|
      format.html { redirect_to(article_path(@article)) }
      format.json  { head :ok }
    end
  end

  private

  def comment_params()
    params.require(:comment).permit(:body) 
  end
  
end
