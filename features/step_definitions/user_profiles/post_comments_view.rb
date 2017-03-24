And(/^few comments on David post/) do
  admin = User.find_by name: 'Admin'
  david = User.find_by name: 'David'
  david_post = Post.find_by user: david
  create :comment, content: 'Wow!', user: admin, post: david_post
  create :comment, content: 'Thank you', user: david, post: david_post
end

Then(/^i should not have ability to manage comments on David page/) do
  expect(page).to have_content 'Wow!'
  expect(page).to have_content 'Thank you'
end

And(/^have ability to manage my comments/) do
  expect(page).to have_selector(:link_or_button, 'Действия')
end
