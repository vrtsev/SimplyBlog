And(/^Press delete button/) do
  click_link 'Удалить'
end

And(/^page should not contain deleted category/) do
  expect(page).to have_no_content('My category')
end
