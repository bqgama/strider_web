class UsersController < ApplicationController
  before_action :set_user, only: :show
  before_action :get_user_posts, only: :show
  before_action :get_information_for_user_profile_page, only: :show

  def show
    render json: { "user": @user, "posts": @posts, "informations": @informations }
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def get_user_posts
      @posts = Post.posts_made_by_this_user(@user.id)
    end

    def get_information_for_user_profile_page
      @informations = {
        "number_of_followers": @user.number_of_followers,
        "number_of_followings": @user.number_of_followings,
        "number_of_posts_made_by_this_user": @posts.count
      }
    end

    def user_params
      params.require(:user).permit(:username, :date_joined)
    end
end
