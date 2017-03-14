Given(/^Post page(delete)/) do
  user = create(:user, name: 'Admin', email: 'admin@example.com', password: 'password')
  login_as(user)
  create :post, user: user
  visit post_path(Post.first)
end

And(/^Post comment(delete)/) do
  create :comment, content: 'My comment', post: Post.last, user: User.last
end

When(/^I click comment delete link/) do
  visit post_path(Post.last)
  click_link 'Удалить коммент.'
end

Then(/^Site should redirect to post page/) do
  expect(page).to have_current_path(post_path(Post.last))
end
