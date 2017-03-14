Given(/^Page with post/) do
  user = create(:user, name: 'Admin', email: 'admin@example.com', password: 'password')
  login_as(user)
  create :post, title: 'Test title', content: 'Some text in content field..', user: user
  visit post_path(Post.last)
  expect(page).to have_content 'Test title'
  expect(page).to have_content 'Some text in content field..'
end

When(/^I click delete link/) do
  click_link 'Удалить пост'
end

Then(/^Site should redirect to profile page/) do
  expect(page).to have_current_path(posts_path)
end

And(/^Page should not contain delete post content/) do
  expect(page).to have_no_content 'Test title'
  expect(page).to have_no_content 'Some text in content field..'
end