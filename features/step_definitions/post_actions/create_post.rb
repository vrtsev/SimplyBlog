Given(/^Post creation form/) do
  user = create(:user, name: 'Admin', email: 'admin@example.com', password: 'password')
  login_as(user)
  visit posts_path
  within(:css, "nav.navbar") { click_link 'Создать запись' }

  expect(page).to have_content("Сообщение")
  page.has_css?('input#post_title')
  page.has_css?('select#post_category_id')
  page.has_css?('input#post_pin')
end

And(/^Filled data in form fields/) do
  fill_in('post[title]', :with => 'My Test title')
  fill_in('post[content]', :with => 'Some text in content field..')
  fill_in('post[tag_list]', :with => 'first, second, third ')
  # select "option_name_here", :from => "organizationSelect"
  # check 'post[pin]'
end

When(/^I click button for post creation/) do
  click_button "Сохранить"
end

Then(/^Site should redirect to created post/) do
  expect(page).to have_current_path(post_path(Post.last))
end

And(/^Page should contain filled content/) do
  expect(page).to have_content 'My Test title'
  expect(page).to have_content 'Some text in content field..'
end