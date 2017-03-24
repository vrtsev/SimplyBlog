Given(/^I am a guest for login/) do
end

When(/^I visit login page/) do
  visit root_path
  click_link 'Войти'
end

And(/^Login to site/) do
  user = create :user, name: 'Admin', email: 'admin@example.com', password: 'password'
  login_as(user)
  visit posts_path
end

Then(/^Site should redirect me to my profile page/) do
  expect(page).to have_content 'Вы вошли как Admin'
  expect(page).to have_content 'Создать запись'
  expect(page).to have_content 'Новая категория'
end
