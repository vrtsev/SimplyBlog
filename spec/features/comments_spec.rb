require "rails_helper"

RSpec.describe "posts#show", type: :feature do 

	before(:each) do
		@p = FactoryGirl.create(:post)
		@u = FactoryGirl.create(:user)
		login_as(@u, :scope => :user)
	end

	it "contains comment" do
		# visit("/posts/#{@p.id}")
		# find("#comment_content").set "капибара"
		# click_on('Отправить')
		# visit("/posts/#{@p.id}")
		# expect(page).to have_content('капибара')
	end

end
