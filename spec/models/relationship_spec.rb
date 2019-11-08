require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @takashi = FactoryBot.create(:takashi)
    @satoshi = FactoryBot.create(:satoshi)
    @follow = FactoryBot.create(:relationship, following: @takashi, follower: @satoshi)
  end

  context "有効なフォロー" do
    it "フォローが有効である" do
      expect(@follow).to be_valid
    end
  end

  context "無効なフォロー" do
    it "フォローしている側のidが存在しない" do
      @follow.following_id = ""
      expect(@follow).not_to be_valid
    end

    it "フォローされている側のidが存在しない" do
      @follow.follower_id = ""
      expect(@follow).not_to be_valid
    end

    it "フォローしている側のidとフォローされている側のidが重複している" do
      duplicate_follow = FactoryBot.build(:relationship, following: @takashi, follower: @satoshi)
      expect(duplicate_follow).not_to be_valid
    end

  end
end
