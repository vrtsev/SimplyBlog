Given(/^I as registered user for new profile/) do
  user = create(:user, name: 'Admin', email: 'admin@example.com', password: 'password')
  login_as(user)
end

When(/^I first time visit my profile page/) do
  visit posts_path
end

Then(/^Page should not contain any posts or categories/) do
  user = User.find_by(name: 'Admin')
  expect(page).to have_content 'Нет записей'
  expect(Post.where(user: user).count).to eq 0
  expect(Category.where(user: user).count).to eq 0
end