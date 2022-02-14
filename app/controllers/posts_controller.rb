class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :set_post_owner, only: :index
  before_action :set_user, only: [:index, :create]


  def index
    if @post_owner == 'All'
      @posts = Post.all
    elsif @post_owner == 'following'
      @posts = Post.where(user_id: @user.followings.pluck(:id))
    end

    render json: @posts
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def set_post_owner
      @post_owner = params[:home_id]
    end

    #Do not build authentication (So I used the first user as authenticated user)
    def set_user
      @user = User.first
    end

    def post_params
      params.require(:post).permit(:body, :kind).merge(user_id: @user.id)
    end
end
