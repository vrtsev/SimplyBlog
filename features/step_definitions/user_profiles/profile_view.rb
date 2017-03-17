Then(/^page should not have link for new category/) do
  expect(page).to have_no_content 'Новая категория'
end
