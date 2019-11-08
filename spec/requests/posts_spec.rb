require 'rails_helper'

def login_user
  @takashi = FactoryBot.create(:takashi)
  post "/login", params: {
    email: @takashi.email,
    password: @takashi.password
  }
end

RSpec.describe PostsController, type: :request do
  context "ログインしていない場合" do
    describe "GET posts#index" do
      it "リクエストが成功する" do
        get "/posts"
        expect(response.status).to eq 200
      end
    end

    before do
      login_user
      @post = FactoryBot.create(:post, user: @takashi)
      delete "/logout"
    end
    describe "GET posts#show" do
      it "リクエストが成功する" do
        get "/posts/#{@post.id}"
        expect(response.status).to eq 200
      end
    end
  end

  context "ログインしている場合" do
    before do
      login_user
      @post = FactoryBot.create(:post, user: @takashi)
    end

    describe "GET posts#index" do
      it "リクエストが成功する" do
        get "/posts"
        expect(response.status).to eq 200
      end

      it "投稿内容が表示されている" do
        @satoshi = FactoryBot.create(:satoshi)
        @other_post = FactoryBot.create(:other_post, user: @satoshi)
        get "/posts"
        expect(response.body).to include "Post"
        expect(response.body).to include "OtherPost"
      end

      it "ユーザー名が表示されている" do
        @satoshi = FactoryBot.create(:satoshi)
        @other_post = FactoryBot.create(:other_post, user: @satoshi)
        get "/posts"
        expect(response.body).to include "Takashi"
        expect(response.body).to include "Satoshi"
      end
    end

    describe "GET posts#show" do
      it "リクエストが成功する" do
        get "/posts/#{@post.id}"
        expect(response.status).to eq 200
      end

      it "投稿内容が表示されている" do
        get "/posts/#{@post.id}"
        expect(response.body).to include "Post"
      end
    end

    describe "GET posts#new" do
      it "リクエストが成功する" do
        get "/posts/new"
        puts is_logged_in?
        expect(response.status).to eq 200
      end
    end

    describe "GET posts#edit" do
      it "リクエストが成功する" do
        get "/posts/#{@post.id}/edit"
        expect(response.status).to eq 200
      end

      it "投稿が表示されている" do
        get "/posts/#{@post.id}/edit"
        expect(response.body).to include "Post"
      end
    end

    describe "POST posts#create" do
      context "パラメータが妥当な場合" do
        it "リクエストが成功する" do
          post "/posts", params: {
            post: {
              content: "hogehoge"
            }
          }
          expect(response.status).to eq 302
        end

        it "投稿が登録される" do
          expect do
            post "/posts", params: {
              post: {
                content: "hogehoge"
              }
            }
          end.to change(Post, :count).by(1)
        end

        it "リダイレクトする" do
          post "/posts", params: {
            post: {
              content: "hogehoge"
            }
          }
          expect(response).to redirect_to "/posts"
        end
      end

      context "パラメータが不正な場合" do
        it "リクエストが成功する" do
          post "/posts", params: {
            post: {
              content: ""
            }
          }
          expect(response.status).to eq 200
        end

        it "投稿が登録されない" do
          expect do
            post "/posts", params: {
              post: {
                content: ""
              }
            }
          end.to_not change(Post, :count)
        end

        it "エラーメッセージが表示される" do
          post "/posts", params: { post: {
              content: ""
            }
          }
          expect(response.body).to include "投稿内容を入力してください"
        end
      end
    end

    describe "PUT posts#update" do
      context "パラメータが妥当な場合" do
        it "リクエストが成功する" do
          put "/posts/#{@post.id}", params: {
            post: {
              content: "hogehoge"
            }
          }
          expect(response.status).to eq 302
        end

        it "投稿が更新される" do
          expect do
            put "/posts/#{@post.id}", params: {
              post: {
                content: "hogehoge"
              }
            }
          end.to change { Post.find(@post.id).content }.from("Post").to("hogehoge")
        end

        it "リダイレクトする" do
          put "/posts/#{@post.id}", params: {
            post: {
              content: "hogehoge"
            }
          }
          expect(response).to redirect_to "/posts/#{@post.id}"
        end
      end

      context "パラメータが不正な場合" do
        it "リクエストが成功する" do
          put "/posts/#{@post.id}", params: {
            post: {
              content: ""
            }
          }
          expect(response.status).to eq 200
        end

        it "投稿が変更されない" do
          expect do
            put "/posts/#{@post.id}", params: {
              post: {
                content: ""
              }
            }
          end.to_not change(Post.find(@post.id), :content)
        end

        it "エラーメッセージが表示される" do
          put "/posts/#{@post.id}", params: {
            post: {
              content: ""
            }
          }
          expect(response.body).to include "投稿内容を入力してください"
        end
      end
    end

    describe "DELETE posts#destroy" do
      it "リクエストが成功する" do
        delete "/posts/#{@post.id}"
        expect(response.status).to eq 302
      end

      it "投稿が削除される" do
        expect do
          delete "/posts/#{@post.id}"
        end.to change(Post, :count).by(-1)
      end

      it "投稿一覧にリダイレクトする" do
        delete "/posts/#{@post.id}"
        expect(response).to redirect_to("/posts")
      end
    end

  end

end
