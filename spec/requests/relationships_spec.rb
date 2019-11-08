require 'rails_helper'

def login_user
  @takashi = FactoryBot.create(:takashi)

  post "/login", params: {
    email: @takashi.email,
    password: @takashi.password
  }
end

RSpec.describe "Relationships", type: :request do
  context "ログインしている場合" do
    before do
      login_user
      @satoshi = FactoryBot.create(:satoshi)
    end

    describe "POST relationships#create with Ajax" do
      it "リクエストが成功する" do
        post "/users/#{@satoshi.id}/relationships", xhr: true
        expect(response.status).to eq 200
      end

      it "フォローできる" do
        expect do
          post "/users/#{@satoshi.id}/relationships", xhr: true
        end.to change(Relationship, :count).by(1)
      end

      it "フォロー一覧に表示される" do
        post "/users/#{@satoshi.id}/relationships", xhr: true
        get "/users/#{@takashi.id}/follows"
        expect(response.body).to include "Satoshi"
      end

      it "フォロワー一覧に表示される" do
        post "/users/#{@satoshi.id}/relationships", xhr: true
        get "/users/#{@satoshi.id}/followers"
        expect(response.body).to include "Takashi"
      end
    end

    describe "DELETE relationships#destroy with Ajax" do
      before do
        # * 先にフォローしておく
        post "/users/#{@satoshi.id}/relationships", xhr: true
      end
      it "リクエストが成功する" do
        delete "/users/#{@satoshi.id}/relationships", xhr: true
        expect(response.status).to eq 200
      end

      it "フォローの解除が成功する" do
        expect do
          delete "/users/#{@satoshi.id}/relationships", xhr: true
        end.to change(Relationship, :count).by(-1)
      end
    end

  end
end
