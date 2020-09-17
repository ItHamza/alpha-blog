class ArticlesController < ApplicationController
  before_action :article_id, only: [:show, :edit, :update, :destroy]
before_action :require_user, except: [:show, :index]
before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit   
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    @article.user = current_user
    if @article.save
      flash[:success] = "Article saved succesfully"
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if  @article.update(params.require(:article).permit(:title, :description))
      flash[:danger] = "Article updated succesfully"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_id
    @article = Article.find(params[:id])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only make changes to your own articles"
      redirect_to @article
    end
  end

end