# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }

  describe 'create' do
    context 'create a new friendship' do

      let!(:params) { { friendship: attributes_for(:friendship) } }

      it 'creates a new friendship' do
        expect { Friendship.create!(params[:friendship]) }.to change(Friendship, :count).by(1)
      end
    end
  end
end