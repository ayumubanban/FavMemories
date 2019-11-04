require 'rails_helper'

RSpec.describe Post, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @takashi = FactoryBot.create(:takashi)
    @apple = FactoryBot.create(:apple, user: @takashi)
  end

  context "投稿が有効であるとき" do
    it "有効な投稿である" do
      expect(@apple).to be_valid
    end
  end

  context "投稿が無効であるとき" do
    it "ユーザーidが存在しない" do
      @apple.user_id = ""
      expect(@apple).not_to be_valid
    end

    it "投稿内容が存在しない" do
      @apple.content = ""
      expect(@apple).not_to be_valid
    end

    it "投稿内容が141文字以上である" do
      @apple.content = "a"*141
      expect(@apple).not_to be_valid
    end
  end
end
