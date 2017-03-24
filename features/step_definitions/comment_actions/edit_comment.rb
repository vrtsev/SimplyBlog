Given(/^Post page for comments/) do
  user = create(:user, name: 'Admin', email: 'admin@example.com', password: 'password')
  login_as(user)
  create :post, user: user
  visit post_path(Post.first)
end

And(/^Post comment/) do
  create :comment, content: 'My comment', post: Post.last, user: User.last
end

When(/^I click comment edit button/) do
  visit post_path(Post.last)
  click_link 'Изменить комментарий'
end

Then(/^I should see comment editing form/) do
  expect(page).to have_content('Изменить комментарий')
  within(:css, 'form.edit_comment') do
    expect(find_field('comment[content]').value).to have_content('My comment')
  end
end

When(/^I fill up comment edit form/) do
  within(:css, 'form.edit_comment') do
    fill_in 'comment[content]', with: 'My edited comment'
  end
end

And(/^press edit button/) do
  within(:css, 'form.edit_comment') do
    click_on 'Изменить'
  end
end

Then(/^site should redirect to post page/) do
  expect(page).to have_current_path(post_path(Post.last))
end

And(/^page should contains modified comment/) do
  expect(page).to have_content 'My edited comment'
  expect(page).to have_no_content 'My comment'
end
