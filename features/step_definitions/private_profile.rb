Given(/^current user/) do
  user = create(:user, name: 'Admin', email: 'admin@example.com', password: 'password')
  login_as(user)
end

And(/^user David with private profile/) do
  @david = create(:user, name: 'David', email: 'david@example.com', password: 'password', visible: false)
end

When(/^I visit David page/) do
  visit("/id#{@david.id}")
end

Then(/^Site should render warning page/) do
  expect(page).to have_content 'Это действие недоступно'
  expect(page).to have_content 'который предпочел скрыть свою страницу,'
end
