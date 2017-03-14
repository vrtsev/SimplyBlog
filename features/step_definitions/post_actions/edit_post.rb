Given(/^Post edit form/) do
  user = create(:user, name: 'Admin', email: 'admin@example.com', password: 'password')
  login_as(user)
  create :post, title: 'Test title', content: 'Some text in content field..', user: user
  visit edit_post_path(Post.last)
  expect(page).to have_content 'Изменение записи'
end

And(/^Filled content of this post/) do
  expect(find_field('post[title]').value).to have_content 'Test title'
  expect(find_field('post[content]').value).to have_content 'Some text in content field..'
end

When(/^I change filled content/) do
  fill_in('post[title]', with: 'Modified title')
  fill_in('post[content]', with: 'Modified content..')
end

And(/^Press button for save edited post/) do
  click_button "Сохранить"
end

Then(/^Site should redirect to edited post/) do
  expect(page).to have_current_path(post_path(Post.last))
end

And(/^Page should contain changed content/) do
  expect(page).to have_content 'Modified title'
  expect(page).to have_content 'Modified content..'
end