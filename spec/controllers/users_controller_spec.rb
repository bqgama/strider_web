# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:current_user) { create(:user) }
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:post1) { create(:post, :original, user: user1) }
  let!(:post2) { create(:post, :repost, user: user1, parent_id: post1.id) }
  let!(:post3) { create(:post, :original, user: user2) }
  let!(:friendship) { create(:friendship, follower_id: current_user.id, following_id: user1.id) }


  describe 'GET#show' do
    before { get :show, params: { id: user1.id } }

    it 'assings user' do
      expect(assigns(:user)).to eql user1
    end

    it 'assings posts' do
      expect(assigns(:posts)).to contain_exactly(post1, post2)
    end

    it 'assings informations' do
      expect(assigns(:informations)).to eql [ {
                                              "number_of_followers": user1.number_of_followers,
                                              "number_of_followings": user1.number_of_followings,
                                              "number_of_posts_made_by_this_user": Post.posts_made_by_this_user(user1.id).count,
                                              "following": true
                                              }
                                            ].first
    end
  end
end