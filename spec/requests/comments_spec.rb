require 'rails_helper'

def login_user
  # comment = FactoryBot.create(:comment)
  @takashi = FactoryBot.create(:takashi)
  post "/login", params: {
    email: @takashi.email,
    password: @takashi.password
  }



  # puts "post_idは#{comment.post_id}"
  # puts "user_idは#{comment.user_id}"
  # puts like.user.inspect
  # puts is_logged_in?
end

RSpec.describe "Comments", type: :request do
  # describe "GET /comments" do
  #   it "works! (now write some real specs)" do
  #     get comments_index_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
  context "ログインしている場合" do
    before do
      login_user
      @apple = FactoryBot.create(:apple, user: @takashi)
    end

    describe "POST comments#create with Ajax" do
      it "リクエストが成功すること" do
        post "/posts/#{@apple.id}/comments", xhr: true, params: {
          comment: FactoryBot.attributes_for(:orange)
        }
        expect(response.status).to eq 200
      end

      it "コメントが投稿できること" do
        expect do
          post "/posts/#{@apple.id}/comments", xhr: true, params: {
            comment: FactoryBot.attributes_for(:orange)
          }
        end.to change(Comment, :count).by(1)
      end
    end

    describe "DELETE comments#destroy with Ajax" do
      before do
        # * 先にコメントしておく
        post "/posts/#{@apple.id}/comments", xhr: true, params: {
          comment: FactoryBot.attributes_for(:orange)
        }
      end
      it "リクエストが成功すること" do
        puts Comment.all.inspect
        delete "/posts/#{@apple.id}/comments/#{Comment.last.id}", xhr: true
        expect(response.status).to eq 200
      end

      it "コメントが削除できること" do
        puts Comment.all.inspect
        expect do
          delete "/posts/#{@apple.id}/comments/#{Comment.last.id}", xhr: true
        end.to change(Comment, :count).by(-1)
      end
    end

  end


end
