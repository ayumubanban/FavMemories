require 'rails_helper'

RSpec.describe Comment, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @takashi = FactoryBot.create(:takashi)
    @apple = FactoryBot.create(:apple, user: @takashi)
    @orange = FactoryBot.create(:orange, post: @apple, user: @takashi)
  end

  context "有効なコメント" do
    it "コメントが有効である" do
      expect(@orange).to be_valid
    end
  end

  context "無効なコメント" do
    it "コメント内容が存在しない" do
      @orange.content = ""
      expect(@orange).not_to be_valid
    end

    it "コメント内容が141文字以上である" do
      @orange.content = "a"*141
      expect(@orange).not_to be_valid
    end

    it "ユーザーidが存在しない" do
      @orange.user_id = ""
      expect(@orange).not_to be_valid
    end

    it "投稿idが存在しない" do
      @orange.post_id = ""
      expect(@orange).not_to be_valid
    end
  end
end
