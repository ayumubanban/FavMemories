require 'rails_helper'

def login_user
  # like = FactoryBot.create(:like)

  # post "/login", params: {
  #   email: like.user.email,
  #   password: like.user.password
  # }

  @takashi = FactoryBot.create(:takashi)

  post "/login", params: {
    email: @takashi.email,
    password: @takashi.password
  }

  # puts "post_idは#{like.post_id}"
  # puts "user_idは#{like.user_id}"
  # puts like.user.inspect
  # puts is_logged_in?
end

RSpec.describe "Likes", type: :request do
  # describe "GET /likes" do
  #   it "works! (now write some real specs)" do
  #     get likes_index_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
  context "ログインしている場合" do
    before do
      login_user
      @apple = FactoryBot.create(:apple, user: @takashi)
    end

    describe "POST likes#create with Ajax" do
      it "リクエストが成功すること" do
        post "/posts/#{@apple.id}/likes", xhr: true
        expect(response.status).to eq 200
      end

      it "いいねが成功すること" do
        expect do
          # post "/posts/#{Post.last.id}/likes", params: {
          #   post_id: Post.last.id,
          #   user_id: User.last.id
          # }
          post "/posts/#{@apple.id}/likes", xhr: true
        end.to change(Like, :count).by(1)
      end

      it "いいね一覧に表示されること" do
        post "/posts/#{@apple.id}/likes", xhr: true
        get "/users/#{@takashi.id}/likes"
        expect(response.body).to include "Apple"
      end
    end

    describe "DELETE likes#destroy with Ajax" do
      before do
        # * 先にいいねしておく
        post "/posts/#{@apple.id}/likes", xhr: true
      end
      it "リクエストが成功すること" do
        delete "/posts/#{@apple.id}/likes", xhr: true
        expect(response.status).to eq 200
      end

      it "いいねの解除が成功すること" do
        expect do
          # post "/posts/#{Post.last.id}/likes", params: {
          #   post_id: Post.last.id,
          #   user_id: User.last.id
          # }
          delete "/posts/#{@apple.id}/likes", xhr: true
        end.to change(Like, :count).by(-1)
      end
    end
  end


end