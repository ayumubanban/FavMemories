require 'rails_helper'

def signup_user
  post "/users/create", params: { user: FactoryBot.attributes_for(:user) }
end

RSpec.describe PostsController, type: :request do
  context "ログインしていない場合" do

  end

  context "ログインしている場合" do
    before do
      signup_user
    end

    describe "GET posts#index" do
      it "リクエストが成功すること" do
        get "/posts/index"
        expect(response.status).to eq 200
      end

      # before do
      #   FactoryBot.create :post
      #   puts "beforeのPost.idは#{Post.last.id}"
      # end
      # it "投稿内容が表示されていること" do
      #   get "/posts/index"
      #   expect(response.body).to include "TestPost#{Post.last.id}"
      #   expect(response.body).to include "TestPost#{Post.last.id-1}"
      # end
    end

    describe "GET posts#show" do

    end

    describe "GET posts#new" do

    end

    describe "GET posts#edit" do

    end

    describe "POST posts#create" do

    end

    describe "POST posts#update" do

    end

    describe "POST posts#destroy" do

    end

    # * コメントに関するテストはまた別で書けばええかなぁ

  end

end
