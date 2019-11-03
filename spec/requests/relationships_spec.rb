require 'rails_helper'

def login_user
  # comment = FactoryBot.create(:comment)

  user = FactoryBot.create(:user)
  other_user = FactoryBot.create(:other_user)

  post "/login", params: {
    email: user.email,
    password: user.password
  }
  puts User.all.inspect

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
    end

    describe "POST relationships#create with Ajax" do
      it "リクエストが成功すること" do
        post "/users/#{User.last.id}/relationships", xhr: true
        expect(response.status).to eq 200
      end

      it "フォローできること" do
        expect do
          post "/users/#{User.last.id}/relationships", xhr: true
        end.to change(Relationship, :count).by(1)
      end
    end

    describe "DELETE relationships#destroy with Ajax" do
      before do
        # * 先にフォローしておく
        post "/users/#{User.last.id}/relationships", xhr: true
      end
      it "リクエストが成功すること" do
        delete "/users/#{User.last.id}/relationships", xhr: true
        expect(response.status).to eq 200
      end

      it "フォローの解除が成功すること" do
        expect do
          delete "/users/#{User.last.id}/relationships", xhr: true
        end.to change(Relationship, :count).by(-1)
      end
    end

  end
end
