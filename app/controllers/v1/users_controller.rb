class V1::UsersController < ApplicationController
  before_action :set_user, only: [:user_articles, :show, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    @users = User.all
    render json: @users,
    status: :ok
  end

  def show
    render json: @user,
    only: [:id, :email, :username, :password],
    status: :ok
  end

  # def user_articles
  #     @articles = @user.articles
  #     @articles = @articles.order("#{params[:method] || 'title'} #{params[:sort_by] || 'ASC' }")
  #     render json: @articles,
  #     only: [:id, :title, :content, :user_id],
  #     status: :ok
  # end

  def new
    @user = User.new
  end

  def create

    begin
      @user = User.new(user_params)
        if @user.save!
          render json: @user, status: :created
        end
    rescue => e
      render(json: { error: e.message }, status: :im_used)
    end

  end

  def update
    begin
      if @user.update!(user_params)
        render json: { Message: "User Updated!" },
        status: :ok
      end
    rescue => e
      render(json: { error: e.message }, status: :unprocessable_entity)
    end
  end

  def destroy
    @user.destroy
    render json: {Message: "User deleted"},
    status: :ok
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    if @user.blank?
      render json: "User not Present!"
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
