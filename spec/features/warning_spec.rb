require "rails_helper"

RSpec.describe "'Warning' template contains" do  

	before(:each) do
		@u = FactoryGirl.create(:user)
		login_as(@u, scope: :user)
		@w = FactoryGirl.create(:warning, title: 'warning_titletest', content: "warning_contenttest", public: @u.id)
	end

	it "create_form" do
		visit("/admins/warnings/new")
		expect(page).to have_content('Заголовок')
		expect(page).to have_content('Сообщение')
	end

	it "edit_form" do
		visit("/admins/warnings/#{@w.id}/edit")
		expect(page).to have_content('Заголовок')
		expect(page).to have_content('Сообщение')
	end
end