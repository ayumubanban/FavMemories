require 'rails_helper'

def signup_user
  post "/users", params: { user: FactoryBot.attributes_for(:user) }
end

RSpec.describe UsersController, type: :request do
  context "ログインしていない場合" do

    describe "GET users#new" do
      it "リクエストが成功すること" do
        get "/signup"
        expect(response.status).to eq 200
      end
    end

    describe "GET users#login_form" do
      it "リクエストが成功すること" do
        get "/login"
        expect(response.status).to eq 200
      end
    end



  end

  context "ログインしている場合" do

    before do
      signup_user
      puts "Userのid: #{User.last.id}"
    end

    describe "POST users#create" do
      it "user IDがセッションに保存されている" do
        expect(session[:user_id]).to eq User.last.id
        expect(is_logged_in?).to be_truthy
      end
    end

    describe "DELETE users#logout" do
      it "ログアウトできる" do
        # ! delete
        delete "/logout"
        expect(is_logged_in?).to be_falsey
      end
    end

    # ? ログインできてるかどうか自体をテスト。これそもそも存在させようかどうか迷う。
    describe "POST users#login" do
      it "ログインが成功する" do
        # ! delete
        delete "/logout"

        # * ストロングパラメータなし
        post "/login", params: {
          email: "Test#{User.last.id}@example.com",
          password: "hogehoge"
        }
        expect(is_logged_in?).to be_truthy
      end
    end

    describe "GET users#index" do

      it "リクエストが成功すること" do
        # * =====signup(login)処理=====
        # * ==========================
        get "/users"
        expect(response.status).to eq 200
      end

      # * こっちのが遅い。まぁ当たり前やけど
      before do
        FactoryBot.create :user
        puts "beforeのUser.idは#{User.last.id}"
      end
      it "ユーザー名が表示されていること" do
        # * =====signup(login)処理=====
        # * ==========================

        get "/users"
        # "User.last.id-1は"
        # puts (User.last.id)-1
        # "User全員"
        # puts User.all.inspect

        expect(response.body).to include "TestUser#{User.last.id}"
        expect(response.body).to include "TestUser#{(User.last.id)-1}"
      end

    end

    describe "GET users#show" do
      context "ユーザーが存在する場合" do

        it "リクエストが成功すること" do
          # # * =====signup(login)処理=====
          # # * ==========================
          get "/users/#{User.last.id}"
          expect(response.status).to eq 200
        end

        it "ユーザー名が表示されていること" do
          # # * =====signup(login)処理=====
          # # * ==========================
          get "/users/#{User.last.id}"
          expect(response.body).to include("TestUser#{User.last.id}")
        end
      end
    end

    describe "GET users#edit" do

      it "リクエストが成功すること" do
        get "/users/#{User.last.id}/edit"
        expect(response.status).to eq 200
      end

      it "ユーザー名が表示されていること" do
        get "/users/#{User.last.id}/edit"
        expect(response.body).to include "TestUser#{User.last.id}"
      end

      it "メールアドレスが表示されていること" do
        get "/users/#{User.last.id}/edit"
        p User.last.id
        expect(response.body).to include "Test#{User.last.id}@example.com"
      end

    end

    describe "PUT users#update" do
      context "パラメータが妥当な場合" do
        it "リクエストが成功すること" do
          # ! ストロングパラメータにした方がいい
          put "/users/#{User.last.id}", params: {
            user: {
              name: "hogege", email: "hoge@hoge.com"
            }
          }
          expect(response.status).to eq 302
        end

        it "ユーザー名が更新されること" do
          # ! ストロングパラメータにした方がいい
          expect do
            put "/users/#{User.last.id}", params: {
              user: {
                name: "hogege", email: "hoge@hoge.com"
              }
            }
          end.to change { User.find(User.last.id).name }.from("TestUser#{User.last.id}").to("hogege")
        end

        it "リダイレクトすること" do
          put "/users/#{User.last.id}", params: {
            user: {
              name: "hogege", email: "hoge@hoge.com"
            }
          }
          expect(response).to redirect_to "/users/#{User.last.id}"
        end
      end

      context "パラメータが不正な場合" do
        it "リクエストが成功すること" do
          # ! ストロングパラメータにした方がいい
          put "/users/#{User.last.id}", params: {
            user: {
              name: "", email: "hoge@hoge.com"
            }
          }
          expect(response.status).to eq 200
        end

        it "ユーザー名が変更されないこと" do
          # ! ストロングパラメータにした方がいい
          expect do
            put "/users/#{User.last.id}", params: {
              user: {
                name: "", email: "hoge@hoge.com"
              }
            }
          end.to_not change(User.find(User.last.id), :name)
        end
      end
    end

    describe "GET users#likes" do
      it "リクエストが成功すること" do
        get "/users/#{User.last.id}/likes"
        expect(response.status).to eq 200
      end
    end

    describe "POST relationships#create" do

    end

    describe "DELETE relationships#destroy" do

    end

    describe "GET users#follows" do
      it "リクエストが成功すること" do
        get "/users/#{User.last.id}/follows"
        expect(response.status).to eq 200
      end
    end

    describe "GET users#followers" do
      it "リクエストが成功すること" do
        get "/users/#{User.last.id}/followers"
        expect(response.status).to eq 200
      end
    end

  end
end
