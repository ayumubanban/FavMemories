require 'rails_helper'

RSpec.describe UsersController, type: :request do

  describe "GET users#new" do
    it "リクエストが成功すること" do
      get "/signup"
      expect(response.status).to eq 200
    end
  end

  describe "POST users#create" do
    let(:user) { FactoryBot.create(:user) }

    it "saves the user ID to the session object" do
      post "/users/create", params: { user: FactoryBot.attributes_for(:user) }

      expect(session[:user_id]).to eq User.last.id
    end
  end

  describe "GET users#login_form" do

  end

  describe "POST users#login" do

  end

  describe "POST users#logout" do

  end

  describe "GET users#index" do

  end

  describe "GET users#show" do

  end

  describe "GET users#edit" do

  end

  describe "POST users#update" do

  end

  describe "GET users#likes" do

  end

  describe "POST relationships#create" do

  end

  describe "POST relationships#destroy" do

  end

  describe "GET users#follows" do

  end

  describe "GET users#followers" do

  end

end
