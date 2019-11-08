require 'rails_helper'

def login_user
  @takashi = FactoryBot.create(:takashi)
  post "/login", params: {
    email: @takashi.email,
    password: @takashi.password
  }
end

RSpec.describe "Comments", type: :request do
  context "ログインしている場合" do
    before do
      login_user
      @post = FactoryBot.create(:post, user: @takashi)
    end

    describe "POST comments#create with Ajax" do
      it "リクエストが成功する" do
        post "/posts/#{@post.id}/comments", xhr: true, params: {
          comment: FactoryBot.attributes_for(:comment)
        }
        expect(response.status).to eq 200
      end

      it "コメントが投稿できる" do
        expect do
          post "/posts/#{@post.id}/comments", xhr: true, params: {
            comment: FactoryBot.attributes_for(:comment)
          }
        end.to change(Comment, :count).by(1)
      end
    end

    describe "DELETE comments#destroy with Ajax" do
      before do
        # * 先にコメントしておく
        post "/posts/#{@post.id}/comments", xhr: true, params: {
          comment: FactoryBot.attributes_for(:comment)
        }
      end
      it "リクエストが成功する" do
        puts Comment.all.inspect
        delete "/posts/#{@post.id}/comments/#{Comment.last.id}", xhr: true
        expect(response.status).to eq 200
      end

      it "コメントが削除できる" do
        puts Comment.all.inspect
        expect do
          delete "/posts/#{@post.id}/comments/#{Comment.last.id}", xhr: true
        end.to change(Comment, :count).by(-1)
      end
    end
  end
end
