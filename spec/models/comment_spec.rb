require "rails_helper"

RSpec.describe Comment do 

	before(:each) do
		@u = FactoryGirl.create(:user)
		@p = FactoryGirl.create(:post)
		@c1 = FactoryGirl.create(:comment, user_id: @u.id, post_id: @p.id )		
  end

	it "creates a new comment" do
		@c1
		expect(Comment.count).to be > 0
	end
	
	it "has user" do
		expect(Comment.last.user_id).to eq(@u.id)		
	end

	it "has post" do
		expect(Comment.last.post_id).to eq(@p.id)		
	end
end