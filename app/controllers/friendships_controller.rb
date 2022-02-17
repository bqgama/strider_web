class FriendshipsController < ApplicationController
  before_action :set_current_user, only: [:index, :create]

  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save!
      render json: @friendship.followings, status: :created
    else
      render json: @friendship.followings, status: :unprocessable_entity
    end
  end

  def destroy
    @friendship = Friendship.users_im_following(@current_user.id).find_by(following_id: params[:following_id])
    @friendship.destroy!
  end

  private
    #Do not build authentication (So I used the first user as authenticated user)
    def set_current_user
      @current_user = User.first
      # @current_user = current_user
    end

    def friendship_params
      params.require(:friendship).permit(:following_id).merge(follower_id: @current_user.id)
    end
end
