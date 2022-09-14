class V1::ArticlesController < ApplicationController

  before_action :search_article, only:[:show, :destroy, :update]
  skip_before_action :verify_authenticity_token

  def index
    if params[:user_id].present?
      @articles = Article.where(user_id: params[:user_id])
    else
      @articles = Article.all
    end

    if params[:name].present?
      @articles = @articles.where('author LIKE ?', '%' + params[:name] + '%')
    end

    #sorting
    #article.order("author ASC") => accept two parameters
    @articles = @articles.order(" #{params[:method] || 'author'} #{params[:sort_by]  || 'ASC'} ")

    #rails 5 => page and per
    #rails 7 => page = offset & per = limit
    @articles = @articles.offset(params[:page]).limit(params[:per])

    render json: @articles,
    status: :ok
  end

  def show
    render json: @article,
          only: [:id, :title, :author, :content, :user_id],
          status: :ok
  end

  def create
    @article = Article.new(article_params)
    @article.save!
    render json: @article, status: :created
  end

  def update
  # byebug
  # puts "------------------------------"
  # puts @article.inspect
    if @article.update(article_params)
      render json: { Message: "Article Updated" },
      status: :ok
    else
      render json: { Message: "un process entity" },
      status: :unprocessable_entity
    end
  end

  def destroy
    if @article.destroy
      render json: { Message: "Article deleted" },
      status: :ok
    else
      render json: { Message: "un process entity" },
      status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author, :user_id)
  end

  def search_article
    @article = Article.find_by( id: params[:id])
    if @article.blank?
      render json: "Article not Present"
    end
  end

end
