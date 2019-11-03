require 'rails_helper'

def login_user
  # post "/users", params: { user: FactoryBot.attributes_for(:user) }

  # post = FactoryBot.create(:post)
  # puts post.content
  # puts post.user_id
  # puts post.user.inspect

  # post "/users", params: { user: {
  #   name: post.user.name,
  #   email: post.user.email,
  #   password: post.user.password
  # } }
  # post "/login", params: {
  #   email: post.user.email,
  #   password: post.user.password
  # }
  # puts user: {
  #   name: post.user.name,
  #   email: post.user.email,
  #   password: post.user.password
  # }
  # post "/users", params: { user: FactoryBot.attributes_for(:user) }
  # puts "現在のPost.last.idは#{Post.last.id}"
  # puts "現在のUser.last.idは#{User.last.id}"
  # puts is_logged_in?
  # puts current_user.inspect

  @takashi = FactoryBot.create(:takashi)
  post "/login", params: {
    email: @takashi.email,
    password: @takashi.password
  }
end

RSpec.describe PostsController, type: :request do
  context "ログインしていない場合" do
    # puts FactoryBot.attributes_for(:user)
  end

  context "ログインしている場合" do
    before do
      login_user
      @apple = FactoryBot.create(:apple, user: @takashi)
    end

    describe "GET posts#index" do
      it "リクエストが成功すること" do
        get "/posts"
        # puts "#{post.user.inspect}"
        expect(response.status).to eq 200
      end

      it "投稿内容が表示されていること" do
        # FactoryBot.attributes_for(:post)
        @satoshi = FactoryBot.create(:satoshi)
        @grape = FactoryBot.create(:grape, user: @satoshi)
        # puts Post.last.id
        # puts Post.all.inspect
        get "/posts"
        expect(response.body).to include "Apple"
        expect(response.body).to include "Grape"
      end

      it "ユーザー名が表示されていること" do
        # FactoryBot.attributes_for(:post)
        @satoshi = FactoryBot.create(:satoshi)
        @grape = FactoryBot.create(:grape, user: @satoshi)
        # puts User.all.inspect
        # puts Post.last.id
        # puts Post.all.inspect
        get "/posts"
        expect(response.body).to include "Takashi"
        expect(response.body).to include "Satoshi"
      end
    end

    describe "GET posts#show" do
      it "リクエストが成功すること" do
        get "/posts/#{@apple.id}"
        # puts "#{post.user.inspect}"
        expect(response.status).to eq 200
      end

      it "投稿内容が表示されていること" do
        get "/posts/#{@apple.id}"
        expect(response.body).to include "Apple"
      end

      # context "投稿が存在しない場合" do
      #   subject { -> { get "/posts/1" } }

      #   # * raise_error エラーが起きることを検証
      #   it { is_expected.to raise_error ActiveRecord::RecordNotFound }
      # end
    end

    describe "GET posts#new" do
      it "リクエストが成功すること" do
        get "/posts/new"
        # puts @current_user.nil?
        puts is_logged_in?
        expect(response.status).to eq 200
      end
    end

    describe "GET posts#edit" do
      it "リクエストが成功すること" do
        # puts Post.all.inspect
        # puts User.all.inspect
        # puts @current_user.nil?
        # puts FactoryBot.attributes_for(:user)
        # puts is_logged_in?
        get "/posts/#{@apple.id}/edit"
        expect(response.status).to eq 200
      end

      it "投稿が表示されていること" do
        get "/posts/#{@apple.id}/edit"
        expect(response.body).to include "Apple"
      end
    end

    describe "POST posts#create" do
      context "パラメータが妥当な場合" do
        it "リクエストが成功すること" do
          post "/posts", params: {
            post: {
              content: "hogehoge"
            }
          }
          # puts User.all.count
          expect(response.status).to eq 302
        end

        it "投稿が登録されること" do
          expect do
            post "/posts", params: {
              post: {
                content: "hogehoge"
              }
            }
          end.to change(Post, :count).by(1)
        end

        it "リダイレクトすること" do
          post "/posts", params: {
            post: {
              content: "hogehoge"
            }
          }
          expect(response).to redirect_to "/posts"
        end
      end

      context "パラメータが不正な場合" do
        it "リクエストが成功すること" do
          post "/posts", params: {
            post: {
              content: ""
            }
          }
          expect(response.status).to eq 200
        end

        it "投稿が登録されないこと" do
          expect do
            post "/posts", params: {
              post: {
                content: ""
              }
            }
          end.to_not change(Post, :count)
        end

        # ! 要日本語化
        it "エラーが表示されること" do
          post "/posts", params: { post: {
              content: ""
            }
          }
          expect(response.body).to include "be blank"
        end
      end
    end

    describe "PUT posts#update" do
      # before do
      #   # * 先に投稿を作っとく
      #   post "/posts", params: {
      #     content: "hogege"
      #   }
      # end
      context "パラメータが妥当な場合" do
        it "リクエストが成功すること" do
          put "/posts/#{@apple.id}", params: {
            post: {
              content: "hogehoge"
            }
          }
          expect(response.status).to eq 302
        end

        it "投稿が更新されること" do
          expect do
            puts Post.all.inspect
            puts current_user.inspect
            puts @apple.id
            puts "/posts/#{@apple.id}"
            puts is_logged_in?
            put "/posts/#{@apple.id}", params: {
              post: {
                content: "hogehoge"
              }
            }
            puts @apple.content
            # puts Post.all.inspect
          end.to change { Post.find(@apple.id).content }.from("Apple").to("hogehoge")
        end

        it "リダイレクトすること" do
          put "/posts/#{@apple.id}", params: {
            post: {
              content: "hogehoge"
            }
          }
          expect(response).to redirect_to "/posts/#{@apple.id}"
        end
      end

      context "パラメータが不正な場合" do
        it "リクエストが成功すること" do
          put "/posts/#{@apple.id}", params: {
            post: {
              content: ""
            }
          }
          # puts Post.last.inspect
          expect(response.status).to eq 200
        end

        it "投稿が変更されないこと" do
          expect do
            put "/posts/#{@apple.id}", params: {
              post: {
                content: ""
              }
            }
          end.to_not change(Post.find(@apple.id), :content)
        end

        # ! これ、要日本語化
        it "エラーメッセージが表示されること" do
          put "/posts/#{@apple.id}", params: {
            post: {
              content: ""
            }
          }
          expect(response.body).to include "be blank"
        end
      end
    end

    describe "DELETE posts#destroy" do
      it "リクエストが成功すること" do
        delete "/posts/#{@apple.id}"
        expect(response.status).to eq 302
      end

      it "投稿が削除されること" do
        expect do
          delete "/posts/#{@apple.id}"
        end.to change(Post, :count).by(-1)
      end

      it "投稿一覧にリダイレクトすること" do
        delete "/posts/#{@apple.id}"
        expect(response).to redirect_to("/posts")
      end
    end

    # * コメントに関するテストはまた別で書けばええかなぁ

  end

end
