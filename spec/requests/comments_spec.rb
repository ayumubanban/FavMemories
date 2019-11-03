require 'rails_helper'

def login_user
  comment = FactoryBot.create(:comment)

  post "/login", params: {
    email: comment.user.email,
    password: comment.user.password
  }

  puts "post_idは#{comment.post_id}"
  puts "user_idは#{comment.user_id}"
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
    end

    describe "POST comments#create with Ajax" do
      it "リクエストが成功すること" do
        post "/posts/#{Post.last.id}/comments", xhr: true, params: {
          comment: FactoryBot.attributes_for(:orange)
        }
        expect(response.status).to eq 200
      end

      it "コメントが投稿できること" do
        expect do
          post "/posts/#{Post.last.id}/comments", xhr: true, params: {
            comment: FactoryBot.attributes_for(:orange)
          }
        end.to change(Comment, :count).by(1)
      end
    end

    describe "DELETE comments#destroy with Ajax" do
      it "リクエストが成功すること" do
        delete "/posts/#{Post.last.id}/comments/#{Comment.last.id}", xhr: true
        expect(response.status).to eq 200
      end

      it "コメントが削除できること" do
        expect do
          delete "/posts/#{Post.last.id}/comments/#{Comment.last.id}", xhr: true
        end.to change(Comment, :count).by(-1)
      end
    end

  end


end
