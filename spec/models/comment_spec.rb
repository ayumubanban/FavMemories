require 'rails_helper'

RSpec.describe Comment, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @takashi = FactoryBot.create(:takashi)
    @post = FactoryBot.create(:post, user: @takashi)
    @comment = FactoryBot.create(:comment, post: @post, user: @takashi)
  end

  context "有効なコメント" do
    it "コメントが有効である" do
      expect(@comment).to be_valid
    end
  end

  context "無効なコメント" do
    it "コメント内容が存在しない" do
      @comment.content = ""
      expect(@comment).not_to be_valid
    end

    it "コメント内容が151文字以上である" do
      @comment.content = "a"*151
      expect(@comment).not_to be_valid
    end

    it "ユーザーidが存在しない" do
      @comment.user_id = ""
      expect(@comment).not_to be_valid
    end

    it "投稿idが存在しない" do
      @comment.post_id = ""
      expect(@comment).not_to be_valid
    end
  end
end
