Given(/^I am a random guest/) do
end

When(/^I visit registration page/) do
  visit root_path
  click_link('Регистрация')
end

And(/^I fill registration fields/) do
  fill_in('user[name]', :with => 'Админ')
  fill_in('user[email]', :with => 'admin@example.com')
  fill_in('user[password]', :with => 'password')
  fill_in('user[password_confirmation]', :with => 'password')
end

And(/^Press register button/) do
  click_button "Продолжить"
end

Then(/^Site should redirect me to my new profile page/) do
  expect(page).to have_content 'Вы вошли как Админ'
  expect(page).to have_content 'Был в сети'
  expect(page).to have_content 'Новая категория'
  expect(page).to have_content 'Нет записей'
end