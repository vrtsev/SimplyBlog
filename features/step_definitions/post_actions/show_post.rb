Given(/^List of user posts/) do
  user = User.first
  login_as(user)
end

When(/^I click on choosen post title/) do
  steps %(
    Given Post creation form
    And Filled data in form fields
    When I click button for post creation
  )
  visit posts_path
  expect(page).to have_content 'My Test title'
  click_link('My Test title')
end

Then(/^Site should redirect to choosen post/) do
  expect(page).to have_current_path(post_path(Post.last))
end

And(/^Page should contain content/) do
  expect(page).to have_content 'My Test title'
  expect(page).to have_content 'Some text in content field..'
end
