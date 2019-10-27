require 'rails_helper'

RSpec.describe UsersController, type: :request do
  # describe "GET /users" do
  #   it "works! (now write some real specs)" do
  #     get users_path
  #     expect(response).to have_http_status(200)
  #   end
  # end

  describe "POST #create" do
    let(:user) { FactoryBot.create(:user) }
    # let(:valid_parameters) do
    #   { name: user.name, email: user.email, password: user.password }
    # end

    it "saves the user ID to the session object" do
      # post "/users/create", session: valid_parameters
      # post "/users/create", params: valid_parameters
      post "/users/create", params: { user: FactoryBot.attributes_for(:user) }
      # post "/users/create", params: { user: user }
      # post "/users/create", params: { user: valid_parameters }

      # expect(session[:user_id]).to eq user.id
      expect(session[:user_id]).to eq User.last.id
    end
  end

end
