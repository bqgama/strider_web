# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship do
  context 'belongs_to' do
    it { should belong_to(:followers) }
    it { should belong_to(:followings) }
  end

  describe '#scope: users_im_following' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:user3) { create(:user) }
    let!(:friendship1) { create(:friendship, follower_id: 1, following_id: 2 ) }
    let!(:friendship2) { create(:friendship, follower_id: 1, following_id: 3 ) }
    let!(:friendship3) { create(:friendship, follower_id: 2, following_id: 1 ) }

    subject { Friendship.users_im_following(user1.id) }

    it { is_expected.to match_array [friendship1, friendship2] }
  end

  describe '#validator: not_follow_myself' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }

    subject { Friendship.new(follower_id: user1.id, following_id: user2.id) }

    it { is_expected.to be_valid }

    context 'is invalid' do
      it 'You can not follow yourself' do
        subject.following_id = user1.id
        subject.valid?
        expect(subject.errors[:following_id]).to match_array("You can't follow yourself")
      end
    end
  end
end