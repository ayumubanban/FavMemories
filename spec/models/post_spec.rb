require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @takashi = FactoryBot.create(:takashi)
    @post = FactoryBot.create(:post, user: @takashi)
  end

  context "投稿が有効であるとき" do
    it "有効な投稿である" do
      expect(@post).to be_valid
    end
  end

  context "投稿が無効であるとき" do
    it "ユーザーidが存在しない" do
      @post.user_id = ""
      expect(@post).not_to be_valid
    end

    it "投稿内容が存在しない" do
      @post.content = ""
      expect(@post).not_to be_valid
    end
  end
end
