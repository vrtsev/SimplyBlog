require "rails_helper"

RSpec.describe "'Diary' template contains" do  

	before(:each) do
		@u = FactoryGirl.create(:user)
		login_as(@u, scope: :user)
		@d = FactoryGirl.create(:diary, title: 'diary_block_titletest', content: "diary_block_contenttest", user_id: @u.id)
		visit("/diaries")
	end

	it "title and content of diary" do
		expect(page).to have_content(@d.title)
		expect(page).to have_content(@d.content)
		expect(page).to have_content(@d.created_at.strftime("%d.%m.%Y в %H:%M:%S"))
	end

	it "invitation message" do
		expect(page).to have_content('Дневник - это Ваше личное пространство')
	end

end