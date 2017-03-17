When(/^i visit category page on David profile/) do
  user = User.find_by name: 'David'
  category = Category.find_by user: user

  visit("/id#{user.id}?category=#{category.id}")
end

Then(/^i should not have ability to manage David category/) do
  expect(page).to have_no_selector(:link_or_button, 'Настройка')
end
