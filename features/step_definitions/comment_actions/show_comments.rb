Given(/^Posts page/) do
  user = create(:user, name: 'Admin', email: 'admin@example.com', password: 'password')
  login_as(user)
  visit posts_path
end

And(/^user posts/) do
  create :post, title: 'Sample post', user: User.last
end

And(/^post comments/) do
  create :comment, content: 'My comment', post: Post.last, user: User.last
end

When(/^i click post title/) do
  visit posts_path
  click_link 'Sample post'
end

Then(/^page should contain comments/) do
  expect(page).to have_content('My comment')
end
