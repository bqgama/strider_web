# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  context 'validations' do
     it { is_expected.to validate_presence_of :username }
     it { should validate_length_of(:username).is_at_most(14) }
     it { should allow_value("username123").for(:username) }
     it { should_not allow_value("username!#").for(:username) }
  end

  describe '#methods' do

    it 'number_of_followers / number_of_followings' do
      user1 = User.create!(username: 'teste1', date_joined: Date.today)
      user2 = User.create!(username: 'teste2', date_joined: Date.today)
      user3 = User.create!(username: 'teste3', date_joined: Date.today)
      Friendship.create!(follower_id: user1.id, following_id: user2.id)
      Friendship.create!(follower_id: user1.id, following_id: user3.id)
      Friendship.create!(follower_id: user2.id, following_id: user1.id)

      expect(user1.number_of_followers).to eql 1
      expect(user1.number_of_followings).to eql 2
    end
  end
end