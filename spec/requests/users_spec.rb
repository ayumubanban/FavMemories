require 'rails_helper'

def login_user
  @takashi = FactoryBot.create(:takashi)
  post "/login", params: {
    email: @takashi.email,
    password: @takashi.password
  }
end

RSpec.describe UsersController, type: :request do
  context "ログインしていない場合" do

    describe "GET home#top" do
      it "リクエストが成功する" do
        get "/"
        expect(response.status).to eq 200
      end
    end

    describe "GET home#about" do
      it "リクエストが成功する" do
        get "/about"
        expect(response.status).to eq 200
      end
    end

    describe "GET users#index" do
      it "リクエストが成功する" do
        get "/users"
        expect(response.status).to eq 200
      end
    end

    describe "GET users#new" do
      it "リクエストが成功する" do
        get "/signup"
        expect(response.status).to eq 200
      end
    end

    describe "GET users#login_form" do
      it "リクエストが成功する" do
        get "/login"
        expect(response.status).to eq 200
      end
    end

    describe "POST users#create" do
      context "パラメータが妥当な場合" do
        it "リクエストが成功する" do
          post "/users", params: {
            user: {
              name: "akihiro",
              email: "akihiro@example.com",
              password: "akihiro"
            }
          }
          expect(response.status).to eq 302
        end

        it "新規登録できる" do
          expect do
            post "/users", params: {
              user: {
                name: "akihiro",
                email: "akihiro@example.com",
                password: "akihiro"
              }
            }
          end.to change(User, :count).by(1)
        end

        it "user IDがセッションに保存されている" do
          post "/users", params: {
            user: {
              name: "akihiro",
              email: "akihiro@example.com",
              password: "akihiro"
            }
          }
          expect(session[:user_id]).to eq User.last.id
        end

        it "リダイレクトする" do
          post "/users", params: {
            user: {
              name: "akihiro",
              email: "akihiro@example.com",
              password: "akihiro"
            }
          }
          expect(response).to redirect_to "/users/#{User.last.id}"
        end
      end

      context "パラメータが不正な場合" do
        it "リクエストが成功する" do
          post "/users", params: {
            user: {
              name: "",
              email: "",
              password: "aaa"
            }
          }
          expect(response.status).to eq 200
        end

        it "新規登録されない" do
          expect do
            post "/users", params: {
            user: {
              name: "",
              email: "",
              password: "aaa"
            }
          }
          end.to_not change(User, :count)
        end

        it "エラーメッセージが表示される" do
          post "/users", params: {
            user: {
              name: "",
              email: "",
              password: "aaa"
            }
          }
          expect(response.body).to include "パスワードは6文字以上で入力してください"
        end
      end

    end

    before do
      login_user
      delete "/logout"
    end
    describe "GET users#show" do
      it "リクエストが成功する" do
        get "/users/#{@takashi.id}"
        expect(response.status).to eq 200
      end
    end

    describe "GET users#likes" do
      it "リクエストが成功する" do
        get "/users/#{@takashi.id}/likes"
        expect(response.status).to eq 200
      end
    end

    describe "GET users#follows" do
      it "リクエストが成功する" do
        get "/users/#{@takashi.id}/follows"
        expect(response.status).to eq 200
      end
    end

    describe "GET users#followers" do
      it "リクエストが成功する" do
        get "/users/#{@takashi.id}/followers"
        expect(response.status).to eq 200
      end
    end

  end

  context "ログインしている場合" do

    before do
      login_user
    end

    describe "DELETE users#logout" do
      it "ログアウトできる" do
        delete "/logout"
        expect(is_logged_in?).to be_falsey
      end
    end

    describe "GET users#index" do
      before do
        @satoshi = FactoryBot.create(:satoshi)
      end

      it "リクエストが成功する" do
        get "/users"
        expect(response.status).to eq 200
      end

      it "ユーザー名が表示されている" do
        get "/users"
        expect(response.body).to include "Takashi"
        expect(response.body).to include "Satoshi"
      end

    end

    describe "GET users#show" do
      context "ユーザーが存在する場合" do

        it "リクエストが成功する" do
          get "/users/#{@takashi.id}"
          expect(response.status).to eq 200
        end

        it "ユーザー名が表示されている" do
          get "/users/#{@takashi.id}"
          expect(response.body).to include("Takashi")
        end
      end
    end

    describe "GET users#edit" do

      it "リクエストが成功する" do
        get "/users/#{@takashi.id}/edit"
        expect(response.status).to eq 200
      end

      it "ユーザー名が表示されている" do
        get "/users/#{@takashi.id}/edit"
        expect(response.body).to include "Takashi"
      end

      it "メールアドレスが表示されている" do
        get "/users/#{@takashi.id}/edit"
        # p User.last.id
        expect(response.body).to include "#{@takashi.email}"
      end

    end

    describe "PUT users#update" do
      context "パラメータが妥当な場合" do
        it "リクエストが成功する" do
          put "/users/#{@takashi.id}", params: {
            user: {
              name: "hogege", email: "hoge@hoge.com"
            }
          }
          expect(response.status).to eq 302
        end

        it "ユーザー名が更新される" do
          expect do
            put "/users/#{@takashi.id}", params: {
              user: {
                name: "hogege", email: "hoge@hoge.com"
              }
            }
          end.to change { User.find(@takashi.id).name }.from("Takashi").to("hogege")
        end

        it "自己紹介文が更新される" do
          expect do
            put "/users/#{@takashi.id}", params: {
              user: {
                name: "hogege", email: "hoge@hoge.com", intro: "よろしくね〜"
              }
            }
          end.to change { User.find(@takashi.id).intro }.from(nil).to("よろしくね〜")
        end

        it "リダイレクトする" do
          put "/users/#{@takashi.id}", params: {
            user: {
              name: "hogege", email: "hoge@hoge.com"
            }
          }
          expect(response).to redirect_to "/users/#{@takashi.id}"
        end
      end

      context "パラメータが不正な場合" do
        it "リクエストが成功する" do
          put "/users/#{@takashi.id}", params: {
            user: {
              name: "", email: "hoge@hoge.com"
            }
          }
          expect(response.status).to eq 200
        end

        it "ユーザー名が変更されない" do
          expect do
            put "/users/#{@takashi.id}", params: {
              user: {
                name: "", email: "hoge@hoge.com"
              }
            }
          end.to_not change(User.find(@takashi.id), :name)
        end

        it "メールアドレスが変更されない" do
          expect do
            put "/users/#{@takashi.id}", params: {
              user: {
                name: "hoge", email: ""
              }
            }
          end.to_not change(User.find(@takashi.id), :email)
        end
      end
    end

  end
end
