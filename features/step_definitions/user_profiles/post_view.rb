When(/^i visit post page of David profile/) do
  david = User.find_by(name: 'David')
  visit("/id#{david.id}" << post_path(Post.last))
end

Then(/^i should not have ability to manage David post/) do
  expect(page).to have_no_selector(:link_or_button, 'Запись')
end
