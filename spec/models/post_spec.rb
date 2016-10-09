require "rails_helper"

RSpec.describe Post, :type => :model do

	it "creates new post" do
		u = FactoryGirl.create(:user)
		p1 = FactoryGirl.create(:post)
		p2 = FactoryGirl.create(:post)

		expect(Post.count).to eq(2)

	end
	
end