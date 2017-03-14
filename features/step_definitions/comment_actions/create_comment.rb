Given(/^Post page/) do
  user = create(:user, name: 'Admin', email: 'admin@example.com', password: 'password')
  login_as(user)
  create :post, user: user
  visit post_path(Post.first)
end

And(/^Comment creation form/) do
  expect(page).to have_css('textarea#comment_content')
end

When(/^I fill up comment form/) do
  fill_in('comment[content]', with: 'My comment')
end

And(/^Press create button/) do
  click_button 'Отправить'
end

Then(/^Site should redirect to profile path/) do
  expect(page).to have_current_path(posts_path)
end

And(/^Post should contain comment with filled content/) do
  visit post_path(Post.last)
  expect(page).to have_content('My comment')
end