require "rails_helper"

RSpec.describe "'Post' template" do  

	describe "with user signed_in contains" do

		before(:each) do
			@u = FactoryGirl.create(:user)
			login_as(@u, scope: :user)
			@p = FactoryGirl.create(:post, title: 'post_block_titletest', content: "post_block_contenttest", user_id: @u.id)
			@c = FactoryGirl.create(:comment, content: 'all_comments_block_content_test', user_id: @u.id, post_id: @p.id)
			visit("/posts/#{@p.id}")
		end

		it "title, content and author of post" do
			expect(page).to have_content(@p.title)
			expect(page).to have_css('p#show_post_content')
			expect(page).to have_css('p#show_post_author')
		end

		it "comment_form_block" do
			expect(page).to have_content('Оскорбительная речь, спам и')
		end

		it "all_comments_block" do
			expect(page).to have_content('all_comments_block_content_test')
		end

	end

#----------------------------------------------------------------------

	describe "WITHOUT signed_in user contains" do

		before(:each) do
			@u = FactoryGirl.create(:user)
			@p = FactoryGirl.create(:post, title: 'post_block_titletest', content: "post_block_contenttest", user_id: @u.id)
			visit("/posts/#{@p.id}")
		end
		
		it "warning instead new comment block" do
			expect(page).to have_content('или Войдите чтобы оставлять комментарии')
		end
	end
end