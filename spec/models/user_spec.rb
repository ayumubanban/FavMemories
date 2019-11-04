require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before do
    @takashi = FactoryBot.create(:takashi, email: "takashi@example.com")
  end

  context "ユーザーが有効であるとき" do
    it "有効なユーザーである" do
      expect(@takashi).to be_valid
    end
  end

  context "ユーザーが無効であるとき" do
    it "名前が空である" do
      @takashi.name = ""
      expect(@takashi).not_to be_valid
    end

    it "ユーザー名が21文字以上である" do
      @takashi.name = "a"*21
      expect(@takashi).not_to be_valid
    end

    it "メールアドレスが空である" do
      @takashi.email = ""
      expect(@takashi).not_to be_valid
    end

    # before do
    #   user = FactoryBot.create(:takashi, email: "takashi@example.com")
    # end
    it "メールアドレスが重複する" do
      other_user = FactoryBot.build(:takashi, email: "takashi@example.com")
      # puts @takashi.email
      expect(other_user).not_to be_valid
    end

    it "パスワードが存在しない" do
      @takashi.password_digest = ""
      expect(@takashi).not_to be_valid
    end
  end

end
