Given(/^List of categories/) do
  user = create(:user, name: 'Admin', email: 'admin@example.com', password: 'password')
  login_as(user)
  create_list :category, 2, user: user
end

When(/^I visit profile page/) do
  visit posts_path
end

Then(/^page should contain categories/) do
  expect(page).to have_content("User category # 1")
  expect(page).to have_content("User category # 2")
end