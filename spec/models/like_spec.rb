require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @takashi = FactoryBot.create(:takashi)
    @post = FactoryBot.create(:post, user: @takashi)
    @like = FactoryBot.create(:like, user: @takashi, post: @post)
  end

  context "有効ないいね" do
    it "いいねが有効である" do
      expect(@like).to be_valid
    end
  end

  context "無効ないいね" do
    it "ユーザーidが存在しない" do
      @like.user_id = ""
      expect(@like).not_to be_valid
    end

    it "投稿idが存在しない" do
      @like.post_id = ""
      expect(@like).not_to be_valid
    end

    it "ユーザーidと記事idが重複している" do
      duplicate_like = FactoryBot.build(:like, user: @takashi, post: @post)
      expect(duplicate_like).not_to be_valid
    end
  end
end
