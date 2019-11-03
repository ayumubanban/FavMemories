require 'rails_helper'

def login_user
  # comment = FactoryBot.create(:comment)

  # takashi = FactoryBot.create(:takashi)
  # satoshi = FactoryBot.create(:satoshi)

  @takashi = FactoryBot.create(:takashi)

  post "/login", params: {
    email: @takashi.email,
    password: @takashi.password
  }
  # puts User.all.inspect

  # puts "post_idは#{comment.post_id}"
  # puts "user_idは#{comment.user_id}"
  # puts like.user.inspect
  # puts is_logged_in?
end

RSpec.describe "Relationships", type: :request do
  # describe "GET /relationships" do
  #   it "works! (now write some real specs)" do
  #     get relationships_index_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
  context "ログインしている場合" do
    before do
      login_user
      @satoshi = FactoryBot.create(:satoshi)
    end

    describe "POST relationships#create with Ajax" do
      it "リクエストが成功すること" do
        post "/users/#{@satoshi.id}/relationships", xhr: true
        expect(response.status).to eq 200
      end

      it "フォローできること" do
        expect do
          post "/users/#{@satoshi.id}/relationships", xhr: true
        end.to change(Relationship, :count).by(1)
      end

      it "フォロー一覧に表示されること" do
        post "/users/#{@satoshi.id}/relationships", xhr: true
        get "/users/#{@takashi.id}/follows"
        expect(response.body).to include "Satoshi"
      end

      it "フォロワー一覧に表示されること" do
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
      it "リクエストが成功すること" do
        delete "/users/#{@satoshi.id}/relationships", xhr: true
        expect(response.status).to eq 200
      end

      it "フォローの解除が成功すること" do
        expect do
          delete "/users/#{@satoshi.id}/relationships", xhr: true
        end.to change(Relationship, :count).by(-1)
      end
    end

  end
end
