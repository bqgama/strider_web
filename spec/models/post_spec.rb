# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post do
  context 'belongs_to' do
    it { should belong_to(:user) }
  end

  context 'validations' do
     it { is_expected.to validate_presence_of :body }
     it { should validate_length_of(:body).is_at_most(777) }
  end

  describe '#scope: posts_made_by_this_user' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:user3) { create(:user) }
    let!(:post1) { create(:post, :original, user: user1) }
    let!(:post2) { create(:post, :repost, user: user1, parent_id: post1.id) }
    let!(:post3) { create(:post, :original, user: user2) }

    subject { Post.posts_made_by_this_user(user1.id) }

    it { is_expected.to match_array [post1, post2] }
  end

  describe '#validator: original_post_dont_have_a_parent' do
    let!(:user1) { create(:user) }
    let!(:post1) { create(:post, :original, user: user1) }

    subject { Post.new(body: "test", kind: :original, user_id: user1.id) }

    it { is_expected.to be_valid }

    context 'is invalid' do
      it 'original with parent_id' do
        subject.parent_id = post1.id
        subject.valid?
        expect(subject.errors[:parent_id]).to match_array('Original post do not have a parent')
      end

      it 'repost without parent_id' do
        subject.kind = "repost"
        subject.valid?
        expect(subject.errors[:parent_id]).to match_array('Reposts and quote posts must have a parent')
      end

      it 'quote_posting without parent_id' do
        subject.kind = "quote_posting"
        subject.valid?
        expect(subject.errors[:parent_id]).to match_array('Reposts and quote posts must have a parent')
      end
    end
  end
end