class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @article = Article.new
  end

  def index
    @articles = Article.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render json: @articles }
    end
  end

  def create
    user = User.find(current_user.id)
    @article = user.articles.create(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render json: @model_class_name }
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    authorize @article
  
    respond_to do |format|
      if @article.update(article_params)
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to(@article) }
        format.json  { head :ok }
      else
        format.html { render action: 'edit' }
        format.json  { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article = Article.find(params[:id])

    authorize @article
    @article.destroy
  
    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.json  { head :ok }
    end
  end

  private

  def article_params()
    params.require(:article).permit(:title, :text)
  end
end
