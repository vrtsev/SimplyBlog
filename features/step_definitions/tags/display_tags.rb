And(/^post of Admin with tags/) do
  admin = User.find_by name: 'Admin'
  login_as(admin)
  visit new_post_path

  fill_in('post[title]', with: 'My post with tags')
  fill_in('post[content]', with: 'Some text in content field..')
  fill_in('post[tag_list]', with: 'first, second, third ')

  steps %(
    When I click button for post creation
    Then Site should redirect to created post
  )
end

When(/^I visit my profile/) do
  visit posts_path
end

Then(/^I see tags under post/) do
  within(:css, 'span.glyphicon-tag') do
    expect(page).to have_content 'first'
    expect(page).to have_content 'second'
    expect(page).to have_content 'third'
  end
end
