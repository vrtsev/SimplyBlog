require "rails_helper"

RSpec.describe "layout", type: :feature do 

	describe "with sidebar" do

		before(:each) do
			@u = FactoryGirl.create(:user)
			login_as(@u, :scope => :user)
			@p = FactoryGirl.create(:post, content: "testpost", user_id: @u.id)
			visit root_path
		end

		it "contains and show page 'Главная'" do
			@w = FactoryGirl.create(:warning, content: 'testwarning', public: true)
			click_on('Главная')
			expect(page).to have_content('testwarning')
			expect(page).to have_content('testpost')
		end

		it "contains and show page 'my_posts'" do
			click_on('Мои публикации')
			expect(page).to have_content('testpost')
		end

		it "contains and show page 'my_comments'" do
			@c = FactoryGirl.create(:comment, content: 'testcomment', post_id: @p.id )
			click_on('Комментарии')
			expect(page).to have_content('testcomment')
		end

		it "contains and show page 'diary'" do
			@d = FactoryGirl.create(:diary, content: "testdiary", user_id: @u.id)
			click_on('Дневник')
			expect(page).to have_content('testdiary')
		end

		it "contains and show page 'edit_profile'" do
			click_on('Профиль')
			expect(page).to have_content('Текущий пароль')
		end

		it "contains and show page 'vk.com'" do
			expect(page).to have_content('Поддержка')
		end

		it "contains and show page 'about'" do
			click_on('О сайте')
			expect(page).to have_content('это ресурс, который позволит Вам')
		end
	end

	describe "sidebar when user logged on" do

		before(:each) do
			@links = ['Мои публикации', 'Комментарии', 'Дневник', 'Профиль']
			@u = FactoryGirl.create(:user)
			login_as(@u, :scope => :user)
			visit root_path
		end

		it "contains these links" do
			expect(page).not_to have_content(@links[0, 1])
		end
	end

	describe "sidebar when user NOT logged on" do

		before(:each) do
			@links = ['Мои публикации', 'Комментарии', 'Дневник', 'Профиль']
			visit root_path
		end

		it "does not contains these links" do
			@links.each do |l|
				expect(page).not_to have_content(l)
			end
		end
	end

end
