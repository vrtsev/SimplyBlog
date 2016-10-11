require "rails_helper"

RSpec.describe "Layout" do  

	describe "with user signed_in contains" do

		before(:each) do
			@u = FactoryGirl.create(:user)
			login_as(@u, scope: :user)
			visit(root_path)
		end

		it "navbar" do
			expect(page).to have_content("Вы вошли как #{@u.email}")
			expect(page).to have_css('#post_create')
			expect(page).to have_css('#diary_create')
		end

		it "sidebar" do
			@links = ['Главная', 'Дневник', 'Профиль', 'Поддержка', 'О сайте']
			@links.each do |l|
				expect(page).to have_content(l)
			end
		end

		it "footer" do
			expect(page).to have_content('SimplyBlog, 2016. All rights reserved. Created by Vadim on RoR')
		end

	end

#----------------------------------------------------------------------

	describe "WITHOUT signed_in user contains" do

		before(:each) do
			visit(root_path)
		end

		it "navbar" do
			expect(page).to have_content("Войти")
			expect(page).not_to have_css('#post_create')
			expect(page).not_to have_css('#diary_create')
		end

		it "sidebar" do
			@links = ['Мои публикации', 'Комментарии', 'Дневник', 'Профиль']
			@links.each do |l|
				expect(page).not_to have_content(l)
			end
		end
	end
end