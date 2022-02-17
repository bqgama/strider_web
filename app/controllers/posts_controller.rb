class PostsController < ApplicationController
  before_action :set_post_owner, only: :index
  before_action :set_current_user, only: [:index, :create]

  def index
    if @post_owner == 'All'
      @posts = Post.all
    elsif @post_owner == 'following'
      @posts = Post.where(user_id: @current_user.followings.pluck(:id))
    end

    render json: @posts
  end

  def create
    cant_create = Post.posts_made_by_this_user(@current_user.id)
                      .order(:created_at).last(5).all? { |post| post.created_at.today? }

    @post = Post.new(post_params)

    if !cant_create && @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
    def set_post_owner
      @post_owner = params[:home_id]
    end

    #Do not build authentication (So I used the first user as authenticated user)
    def set_current_user
      @current_user = User.first
      # @current_user = current_user
    end

    def post_params
      params.require(:post).permit(:body, :kind).merge(user_id: @current_user.id)
    end
end
