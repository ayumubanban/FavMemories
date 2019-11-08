require 'rails_helper'

def login_user
  @takashi = FactoryBot.create(:takashi)

  post "/login", params: {
    email: @takashi.email,
    password: @takashi.password
  }
end

RSpec.describe "Likes", type: :request do
  context "ログインしている場合" do
    before do
      login_user
      @post = FactoryBot.create(:post, user: @takashi)
    end

    describe "POST likes#create with Ajax" do
      it "リクエストが成功する" do
        post "/posts/#{@post.id}/likes", xhr: true
        expect(response.status).to eq 200
      end

      it "いいねが成功する" do
        expect do
          post "/posts/#{@post.id}/likes", xhr: true
        end.to change(Like, :count).by(1)
      end

      it "いいね一覧に表示される" do
        post "/posts/#{@post.id}/likes", xhr: true
        get "/users/#{@takashi.id}/likes"
        expect(response.body).to include "Post"
      end
    end

    describe "DELETE likes#destroy with Ajax" do
      before do
        # * 先にいいねしておく
        post "/posts/#{@post.id}/likes", xhr: true
      end
      it "リクエストが成功する" do
        delete "/posts/#{@post.id}/likes", xhr: true
        expect(response.status).to eq 200
      end

      it "いいねの解除が成功する" do
        expect do
          delete "/posts/#{@post.id}/likes", xhr: true
        end.to change(Like, :count).by(-1)
      end
    end
  end
end
