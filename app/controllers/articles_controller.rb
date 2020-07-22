class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def index
    @article = Article.all
  
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json  { render json: @articles }
    # end
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  
    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json  { render json: @model_class_name }
    # end
  end

  private

  def article_params()
    params.require(:article).permit(:title, :text)
  end
end
