Given(/^I am a guest$/) do
end

When(/^I visit the landing page$/) do
  visit root_url
end

Then(/^I see all available registrations buttons$/) do
  expect(page).to have_content 'Simplyblog'
  expect(page).to have_content 'Бесплатная регистрация'
  expect(page).to have_content 'Войти с помощью VK'
  expect(page).to have_content 'Войти с помощью Google'
end
