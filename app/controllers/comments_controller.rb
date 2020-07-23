class CommentsController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

  def create
    @article = Article.find(params[:article_id])

    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
  
    respond_to do |format|
      format.html { redirect_to(article_path(@article)) }
      format.json  { head :ok }
    end
  end

  private

  def comment_params()
    params.require(:comment).permit(:commenter, :body) 
  end
  
end
