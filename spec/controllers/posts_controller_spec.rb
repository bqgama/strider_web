# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:current_user) { create(:user) }
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:post1) { create(:post, :original, user: user1) }
  let!(:post2) { create(:post, :repost, user: user1, parent_id: post1.id) }
  let!(:post3) { create(:post, :original, user: user2) }
  let!(:friendship) { create(:friendship, follower_id: current_user.id, following_id: user1.id) }

  describe 'GET#index' do
    context 'toggle switch All' do

      before { get :index, params: {home_id: 'All'} }

      it 'assigns objects' do
        expect(assigns(:posts)).to contain_exactly(post1, post2, post3)
      end
    end

    context 'toggle switch following' do

      before { get :index, params: {home_id: 'following'} }

      it 'assigns objects' do
        expect(assigns(:posts)).to contain_exactly(post1, post2)
      end
    end
  end

  describe 'POST#create' do
    context 'create a new post' do

      let!(:params) { { post: attributes_for(:post, :original, user_id: user1.id) } }

      it 'creates a new post' do
        expect { Post.create!(params[:post]) }.to change(Post, :count).by(1)
      end
    end
  end
end