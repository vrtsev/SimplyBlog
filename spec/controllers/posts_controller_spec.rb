require "rails_helper"

RSpec.describe PostsController, type: :controller do

  describe "GET #index" do

    it "responds succesfully" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "render the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the posts into @posts" do
      p1 = FactoryGirl.create(:post)
      p2 = FactoryGirl.create(:post)

      get :index
      expect(assigns(:posts)).to match_array([p1, p2])
    end
  end
end