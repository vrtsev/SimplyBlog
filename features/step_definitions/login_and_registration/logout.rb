Given(/^I as registered user for logout/) do
  user = create(:user, name: 'Admin', email: 'admin@example.com', password: 'password')
  login_as(user)
end

When(/^I click logout link/) do
  visit posts_path
  click_link 'Выйти'
end

Then(/^Site should redirect me to landing page/) do
  expect(page).to have_content 'Simplyblog'
  expect(page).to have_content 'Бесплатная регистрация'
  expect(page).to have_content 'Войти с помощью VK'
  expect(page).to have_content 'Войти с помощью Google'
end
